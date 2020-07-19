module ItemsHelper
    def li_class_for_item(item)
        "completed" if item.complete?
    end 

    def li_for_item(item)
        content_tag :li, item, :class => li_class_for_item(item) do
            #What goes here
            yield
        end 
    end 

#    def form_for_item_status(item)
#         form_for([item.list, item]) do |f| 
#             f.check_box :status, :class => "completed", :checked => item.complete? 
#             f.submit
            
#         end
#    end

end
