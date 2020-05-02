module Spina
  class SchoolsController < Spina::ApplicationController

    layout 'layouts/default/application'

    def index
      @schools = render json: Spina::School.all
    end
  end
end