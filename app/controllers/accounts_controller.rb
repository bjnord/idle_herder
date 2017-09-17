class AccountsController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :build_account_hero, only: [:show, :wish_list]
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html { redirect_to current_account }
    end
  end

  def show
    @account_hero = @account.account_heroes.build
  end

  def wish_list
  end

protected

  def build_account_hero
    @account_hero = current_account.account_heroes.build
  end
end
