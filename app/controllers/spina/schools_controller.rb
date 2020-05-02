module Spina
  class SchoolsController < Spina::ApplicationController

    layout 'layouts/default/application'

    def index
      @schools = Spina::School.all
    end
  end
end