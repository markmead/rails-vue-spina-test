module Spina
  module Admin
    class SchoolsController < AdminController
      before_action :set_breadcrumb
      before_action :set_school, only: [:edit, :update, :destroy]

      def index
        @schools = Spina::School.all
      end

      def new
        @school = Spina::School.new
      end

      def create
        @school = Spina::School.new(school_params)

        if @school.save
          redirect_to spina.admin_schools_url
        else
          render :new
        end
      end

      def edit; end
      
      def update
        if @school.update(school_params)
          redirect_to spina.admin_schools_url
        else
          render :edit
        end
      end

      def destroy
        @school.destroy

        redirect_to spina.admin_schools_url
      end

      private

      def set_school
        @school = Spina::School.find(params[:id])
      end

      def school_params
        params.require(:school).permit(:title, :county, :min_age, :max_age)
      end

      def set_breadcrumb
        add_breadcrumb 'Schools', spina.admin_schools_path
      end
    end
  end
end
