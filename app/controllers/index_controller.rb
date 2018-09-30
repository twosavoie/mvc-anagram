get '/' do
  erb :index
end

# get the input from the user. convert the input string into an array (chars), alphabetize it (sort) and re-form the string (join). Return an array (anagrams) from the db (letters) that matches the user's string (alphabetized_string). Return an array of AR objects (see show.erb)
get '/anagrams/:word' do
  @word = params[:word]
  alphabetized_string = @word.chars.sort.join
  @anagrams = Word.where("letters=?", alphabetized_string)
  erb :show
end

post '/' do
  @word = params[:word]
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
