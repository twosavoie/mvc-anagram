class Word < ActiveRecord::Base
  before_create :add_letters # some examples I found have _save in addition to or instead of _create

  def add_letters #this is an instance method rather than a class method
    characters = self.text.chars # self in place of object name. within an instance method, self references the object you're calling the method on
    alphabetized_characters = characters.sort
    self.letters = alphabetized_characters.join
#    word.save # do I need this? not in the lesson
  end

  def self.three_letters?(input) #saw an answer with this after reverse
    if input.length <= 3
      true
    else
      false
    end
  end

  def self.distinct_letters?(input)
    letter_array = input.chars
    unique_letters = letter_array.uniq
    if unique_letters.length < letter_array.length
      false
    else
      true
    end
  end

  def self.valid_input(input) # took out "?" because no longer T/F
    if input.length > 3
      raise Exception.new("Word must be less than or equal to 3 characters.")
    elsif distinct_letters?(input) == false
      raise Exception.new("There are no anagrams for this word.")
#    if three_letters?(input) && distinct_letters?(input)
#      true
#    else
#      false # Taken out to refactor code with Exceptions
    end
  end

  def self.find_anagrams(string)
    anagrams = []
    # Convert word to an array of letters
    letters = string.split(//)

    # Create an array to store our anagrams
    combinations = []

    # Loop through each letter in letters
    letters.each do |letter|
      # Select the remaining letters
      remaining = letters.select { |l| l != letter }

      # Create a new word by combining the letter + the remaining letters
      # Add new word to anagram array
      anagrams << letter + remaining.join('')
      anagrams << letter + reverse_letters(remaining).join('')
    end

    anagrams.each do |potential|
      if Word.find_by_text(potential).present?
        combinations << potential
      end
    end

    # Return anagrams array
    combinations
  end

  def self.reverse_letters(letters)
    # Create a new array of 2 items
    length = letters.length
    reverse_letters = Array.new(length)

    # Loop through letters and keep index
    letters.each_with_index do |letter, index|
      reverse_letters[length - index - 1] = letter
    end

    reverse_letters
  end
end
