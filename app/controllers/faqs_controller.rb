class FaqsController < ApplicationController
    before_action :super_user, only: [:edit, :update]
    before_action :admin_user, only: [:edit, :update, :create, :new, :destroy]

    def index
        @faqs = Faq.paginate(page: params[:page])
    end

    def new
        @faq = Faq.new
    end

    def update
        if @faq.update_attributes(faq_params)
            flash[:success] = 'FAQ updated!'
            redirect_to faqs_path
        else
            render 'edit'
        end
    end

    def show
    end

    def create
        @faq = current_user.faqs.build(faq_params)
        if @faq.save
            flash[:success] = 'FAQ created!'
            redirect_to faqs_path
        else
            render 'new'
        end
    end

    def destroy
        Faq.find(params[:id]).destroy
        flash[:success] = 'FAQ deleted!'
        redirect_to request.referrer || root_url
    end

    private

    def faq_params
        params.require(:faq).permit(:content, :title, :subtitle, :picture)
    end

    def super_user
        @faq = Faq.find_by(id: params[:id])
        redirect_to faqs_path if @faq.nil?
    end
end
