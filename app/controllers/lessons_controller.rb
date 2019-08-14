class LessonsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_authorized_for_current_lesson, only: [:show]


    def show
    end


    private

    def require_authorized_for_current_lesson
        @course = current_lesson.section.course
        if @current_user.enrolled_in?
            redirect_to redirect_to course, alert: 'You are not enrolled in this course'
        else
            render :new, status: :unprocessable_entity
        end
    end

    helper_method :current_lesson
    def current_lesson
        @current_lesson ||= Lesson.find(params[:id])
    end
end
