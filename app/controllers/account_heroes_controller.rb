class AccountHeroesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_account
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def index
    authorize! :read, @account
    @account_heroes = @account.account_heroes.includes(:hero)
  end

  def show
    @account_hero = AccountHero.find(params[:id])
    authorize! :read, @account_hero
  end

  def edit
    @account_hero = AccountHero.find(params[:id])
    respond_modal_with @account_hero
  end

  def create
    authorize! :create, @account
    @account_hero = @account.account_heroes.build({type: 'SpecificAccountHero'}.merge(secure_params('SpecificAccountHero')))
    respond_to do |format|
      if @account_hero.save
        format.html {
          if @account_hero.wish_list?
            redirect_to goals_account_url(@account), notice: 'Hero added to wish list'
          else
            redirect_to account_url(@account), notice: 'Hero added'
          end
        }
        format.json { render :json, @account_hero, status: :created }
      else
        format.html { redirect_to account_url(@account), alert: "Couldn't add hero: #{@account_hero.errors.full_messages.join(', ')}" }
        format.json { render json: @account_hero.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :create, @account
    @account_hero = AccountHero.find(params[:id])
    @account_hero.update(secure_params(@account_hero.type))
    # FIXME flash success/failure not appearing
    # FIXME can't switch level to shards or vice-versa (silent error)
    respond_modal_with @account_hero, location: account_url(@account)
  end

  def destroy
    authorize! :create, @account
    @account_hero = AccountHero.find(params[:id])
    @account_hero.destroy
    # FIXME flash success/failure not appearing
    respond_modal_with @account_hero, location: account_url(@account)
  end

private

  # TODO the routes for this controller should be nested, as in:
  #        /accounts/:account_id/account_heroes[/:id]
  #      and we should take the :account_id from the path:
  #        @account = Account.find(params[:account_id])
  def set_account
    @account = current_account
  end

  def secure_params(type)
    # NB take :account_id from @account to prevent shenanigans
    case type
    when 'SpecificAccountHero'
      params.require(:specific_account_hero).permit(:hero_id, :level, :shards, :priority, :is_fodder, :description, :wish_list, :target_stars)
    when 'GenericAccountHero'
      params.require(:generic_account_hero).permit(:shards, :priority, :is_fodder, :description, :g_stars, :g_faction)
    end
  end
end
