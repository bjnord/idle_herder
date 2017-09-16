class AccountHeroesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_account
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def index
    authorize! :read, @account
    @account_heroes = @account.account_heroes.includes(:hero, :shard_type)
  end

  def show
    @account_hero = AccountHero.find(params[:id])
    authorize! :read, @account_hero
  end

  def create
    authorize! :create, @account
    @account_hero = @account.account_heroes.build(secure_params)
    respond_to do |format|
      if @account_hero.save
        format.html { redirect_to account_url(@account), notice: 'Hero added' }
        format.json { render :json, @account_hero, status: :created }
      else
        format.html { redirect_to account_url(@account), alert: "Couldn't add hero: #{@account_hero.errors.full_messages.join(', ')}" }
        format.json { render json: @account_hero.errors, status: :unprocessable_entity }
      end
    end
  end

private

  # TODO the routes for this controller should be nested, as in:
  #        /accounts/:account_id/account_heroes[/:id]
  #      and we should take the :account_id from the path:
  #        @account = Account.find(params[:account_id])
  def set_account
    @account = current_user.accounts.first
  end

  def secure_params
    # NB take :account_id from @account to avoid shenanigans
    params.require(:account_hero).permit(:hero_id, :shard_type_id, :level, :shards, :priority, :is_fodder, :description, :wish_list)
  end
end
