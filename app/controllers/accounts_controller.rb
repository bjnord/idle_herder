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
  end
end
