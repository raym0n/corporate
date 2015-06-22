class Web::Account::InvitesController < Web::Account::ApplicationController
  def new
    @invite_form = InviteForm.new
  end

  def create
    @invite_form = InviteForm.new invite_form_params
    if @invite_form.valid?
      InviteService.perform @invite_form, current_user
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def invite_form_params
    params.require(:invite_form).permit(:email)
  end
end