require 'mailgun'
class YubinController < ApplicationController
    def index
        
        
    end
    def write
        @almond = params[:title]
        @anchoby = params[:content]
        @who = params[:email]
        @from = params[:from]
        
        mg_client = Mailgun::Client.new("key-e76d569f4aab39378788e5e05307ca21")

    message_params =  {
                   from: @from,
                   to:   @who,
                   subject: @almond,
                   text:    @anchoby
                  }

    result = mg_client.send_message('sandbox8cdaab0f545b464f977ee5ca49df5914.mailgun.org', message_params).to_h!

    message_id = result['id']
    message = result['message']
    
       new_post = Post.new
       new_post.title = @almond
       new_post.content = @anchoby
       new_post.from = @from
       new_post.who = @who
       new_post.save
       

    
    end
    def list
        @every_post = Post.all.order("id desc")        
    end
    
    def update
       @one_post = Post.find(params[:id])
       @one_post.from = params[:from]
       @one_post.who = params[:who]
        @one_post.title = params[:title]
        @one_post.content = params[:content]
        @one_post.save
        redirect_to "/list"
    
    end
    def update_view
        @one_post = Post.find(params[:id])
        
    
    end
    
    def destroy
       @one_post = Post.find(params[:id]) 
       @one_post.destroy 
       redirect_to "/list"
    end
end
