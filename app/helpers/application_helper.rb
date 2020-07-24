module ApplicationHelper
    def title(text)
        content_for :title, text
    end

    def navbar
        if logged_in?
            render "layouts/logged_in_navbar"
        else
            render "layouts/logged_out_navbar"
        end 
    end 
end
