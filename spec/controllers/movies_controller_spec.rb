require 'spec_helper'

describe MoviesController do
  describe 'searching TMDb' do
	before :each do
		@fake_results = [mock('movie1'), mock('movie2')]
	end
    it 'should call the model method that performs TMDb search' do
		Movie.should_receive(:find_in_tmdb).with('hardware').and_return(@fake_results)
		post :search_tmdb, {:search_terms => 'hardware'}  
	end
	describe 'after valid search' do
		before :each do
			Movie.stub(:find_in_tmdb).and_return(@fake_results)
			post :search_tmdb, {:search_terms => 'hardware'}
		end
		it 'should select the Search Results template for rendering' do
			response.should render_template('search_tmdb')
		end
		it 'should make the TMDb search results available to that template' do
			assigns(:movies).should == @fake_results
		end
	end
  end
   
  describe 'Find Movies With Same Director' do
	before :each do
		@similar_movie_results = [mock('Star Wars'), mock('THX-1138')]
	end
	it 'should call the model method that performs similar movies search' do
		Movie.should_receive(:find_similar_movies).with('George Lucas').and_return(@fake_results)
		post :similar_movies, {:director => 'George Lucas'}
	end
	describe 'after link click' do
		before :each do
			Movie.stub(:find_similar_movies).and_return(@similar_movie_results)
			post :similar_movies, {:director => 'George Lucas'}
		end
		it 'should select the similar movies template for rendering' do
			response.should render_template('similar_movies')		
		end
		it 'should make the similar movies avalible to that template' do
			assigns(:movies).should == @similar_movie_results		
		end  
	end
  end
  
  describe 'Run through basic features on the home page' do  
	before :each do
		@fake_movie = FactoryGirl.build(:movie)
	end
	it 'should be able to go to the home page' do
		post :index
		response.should render_template('index')
	end
	
#	describe "PUT 'update/:id'" do
#		it 'should be able to edit' do
#			@mv = {:id => 1	:title => "new title", :rating => "G", :director => "Billy Bob", :release_date => "1979-01-05"}
#			put :update, :id => @fake_movie.id, :movie => @mv
#			@fake_movie.reload
#			@fake_movie.title.should == @mv.title		
#		end
#	end
	
	describe 'after link click' do  
		before :each do		
		end
		it 'should make movies avalible to the homepage' do 
		end
	end
  
  end
  
end