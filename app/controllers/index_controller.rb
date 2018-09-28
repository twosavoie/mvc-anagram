get '/' do
  erb :index
end

get '/anagrams/:word' do
  @word = params[:word]
  @anagrams = Word.find_anagrams(@word)
  erb :show
end

post '/' do
  @word = params[:word] # do I need @word or word? pretty sure @word
  begin # means "start watching out for an exception"
#  if Word.valid_input?(word)
  Word.valid_input(@word)
    redirect "/anagrams/#{@word}"
  rescue Exception => error # how to "rescue" the situation
#  else
    @error = error.message
    erb :index
  end
end
