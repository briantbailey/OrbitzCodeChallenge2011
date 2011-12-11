class KeypadDecoder
  
  #This function decodes an encoded string into a decoded one
  #The functions argument is an encoded string and it returs a decoded string withou a newline
  def decode_line(in_string)
  
    #Define character values for each number on the keypad in a hash of arrays
    char_values = {"2"=>["a","b","c"], "3"=>["d","e","f"], "4"=>["g","h","i"], "5"=>["j","k","l"], "6"=>["m","n","o"], "7"=>["p","q","r","s"], "8"=>["t","u","v"], "9"=>["w","x","y","z"]}
  
    #Initialize functions local variables
    output_string = ''
    char_count = 0
    previous_char = ''
  
    #Start Looping through each character in the string
    in_string.each_byte do |c|
      case c.chr
      when ('2'..'9')
        #Check if current character is a repeat of the previous character
        if c.chr == previous_char
          #Character is a repeat, increment char_count and remove last character in output_string
          char_count += 1
          output_string.chop!
          #Test if key was repeated more times than there are letters on that key
          if char_count > (char_values[c.chr].length - 1)
            #Take modulus char_count % (array length for number key - 1) to determine position in array 
            char_count %= (char_values[c.chr].length - 1)
            #Subtract one to align it with the array start count of 0 unless it is already 0
            unless char_count == 0
              char_count -= 1
            end
          end
          #output calculated repeat character to output_string
          output_string << char_values[c.chr][char_count]
        else
          #Character is not a repeat, zero char_count and add character to output_string
          char_count = 0
          output_string << char_values[c.chr][char_count]
        end
      
      when '0'
        #Current character is a 0, output a space to output_string
        char_count = 0
        output_string << ' '
      
      when '#'
        #Current character is a #, delete last character from output_string
        char_count = 0
        output_string.chop!
      
      when ' '
        #Current character is a space, pause in input, zero char_count, no output to output_string
        char_count = 0
      
      when '1', '*'
        #Current character is a 1 or *, treat same as space, zero char_count, no output to output_string
        char_count = 0
      end
      
      #store current character in the previous_char variable before end of loop
      previous_char = c.chr
    end
  
    #Return decoded string from function
    return output_string
  end
  
  
  #This is the main decode file function
  #The functions arguments are an open file object for the in_file and the out_file
  def decode_file(in_file, out_file)
    #Read first line into variable to determine the number of lines in the file
  	@number_of_lines = in_file.gets
    @number_of_lines = @number_of_lines.to_i

    #Read the remaining encoded lines into array, initialize case_number to 1
    @lines_to_decode = in_file.readlines
    case_number = 1
    
    #Loop through lines array, decode and output to file each line
  	@lines_to_decode.each do |i|
      out_file.puts "Case \##{case_number}: " + self.decode_line(i)
      case_number += 1
  	end
  end

end