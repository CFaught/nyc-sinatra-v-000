class FiguresController < ApplicationController
  
  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/edit'
  end

  get '/figures/new' do

    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/show'
  end

  get '/figures' do
    erb :'/figures/index'
  end

  post '/figures' do
    # binding.pry
    figure = Figure.create(name: params[:figure][:name])

    if !!params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        figure.titles << Title.find(title_id)
      end
    end

    if !!params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        figure.landmarks << Landmark.find(landmark_id)
      end
    end

    if !params[:title][:name].empty?
      figure.titles << Title.create(name: params[:title][:name])
    end

    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    figure.save
    redirect "/figures/#{ figure.id }"
  end
end
