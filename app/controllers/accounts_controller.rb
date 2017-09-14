class AccountsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @account = current_user.accounts.first
    respond_to do |format|
      format.html { redirect_to @account }
    end
  end

  def show
    @account_hero = @account.account_heroes.build
    set_add_hero_panel
  end

private

  # this panel is open if we just added a hero; otherwise is closed
  def set_add_hero_panel
    @add_hero_panel_display = session[:add_hero_panel_display] || 'none';
    session[:add_hero_panel_display] = 'none';
  end
end
