class CertificatesController < ApplicationController

  before_action :logged_in_user,  only: [:create, :destroy, :new]
  before_action :correct_user,    only: [:destroy, :edit, :update, :show]
  before_action :admin_user,      only: [:destroy]

  def index
    @certificates = Certificate.all
  end

  def new
    @certificate = Certificate.new
  end

  def update
      if @certificate.update_attributes(certificate_params)
          redirect_to certificates_path
      else
          render 'edit'
      end
  end

  def show

  end

  def create
      @certificate = current_user.certificates.build(certificate_params)
      if @certificate.save
          flash[:success] = 'Application submitted!'
          redirect_to certificates_path
      else
          render 'new'
      end
  end

  def destroy
      Certificate.find(params[:id]).destroy
      flash[:success] = 'Application deleted!'
      redirect_to request.referrer || root_url
  end

  private

    def certificate_params
      params.require(:certificate).permit(:name, :department, :description,
                                          :birthdate, :graduation,
                                          :copies, :language, :phone)
    end

    def correct_user
        @certificate = current_user.certificates.find_by(id: params[:id])
        redirect_to root_url if @certificate.nil?
    end
end
