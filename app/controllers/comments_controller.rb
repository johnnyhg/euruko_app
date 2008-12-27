class CommentsController < ApplicationController

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @paper = Paper.find_by_id(params[:paper_id])
    @comment.paper  = @paper
    @comment.user   = current_user

    
    respond_to do |format|
      if @comment.save
        logger.debug( "comentario guardado")
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to paper_path(@paper) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        logger.debug( "error en comentario: #{@comment.errors.full_messages}")
        format.html { render :template => 'papers/show' }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

end
