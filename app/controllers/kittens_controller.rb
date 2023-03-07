class KittensController < ApplicationController
    def index
        @kittens = Kitten.all

        repond_to do |f|
            f.html
            f.json {render json: @kittens}
        end
    end

    def show
        @kitten = Kitten.find(params[:id])

        respond_to do |f|
            f.html
            f.json {render json: @kitten}
        end
    end

    def new
        @kitten = Kitten.new

        respond_to do |f|
            f.html
            f.json {render json: @kitten}
        end
    end

    def create
        @kitten = Kitten.new(kitten_params)
        if @kitten.save
            repond_to do |f|
                f.html do
                    flash[:res] = 'Congratulations! You created a kitten'
                    redirect_to @kitten
                end
                f.json {render json: @kitten}
            end
        else
            flash[:res] = 'Something went wrong. There\'s no new kitten'
            repond_to do |f|
                f.html do
                    render :new, status: :unprocessable_entity
                end
                f.json {render json: flash[:res], status: :unprocessable_entity}
            end
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])

        respond_to do |f|
            f.html
            f.json {render json: @kitten}
        end
    end

    def update
        @kitten = Kitten.find(params[:id])
        if @kitten.update(kitten_params)
            respond_to do |f|
                f.html do
                    flash[:res] = 'Congratulations! You updated a kitten'
                    redirect_to @kitten
                end
                f.json {render json: @kitten}
            end
        else
            flash[:res] = 'Something went wrong. Kitten didn\'t change'
            repond_to do |f|
                f.html do
                    render :edit, status: :unprocessable_entity
                end
                f.json {render json: flash[:res], status: :unprocessable_entity}
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        @kitten.destroy
        flash[:res] = 'Congratulations! Kitten is gone'

        repond_to do |f|
            f.html do
                redirect_to root_path
            end
            f.json {render json: flash[:res]}
        end
    end

    private
    def kitten_params
        params.require(:kitten).permit!
    end
end
