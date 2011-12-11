require './KeypadDecoder.rb'

#program text introduction and description output to terminal
puts "\nThis program converts the keypad encoded file messaging.in in the data \ndirectory to the decoded plain text file messagin.out in the data directory.\n\nPress Enter to continue."
#wait for user to hit enter
gets

#File path variables
path_in = '../data/messaging.in'
path_out = '../data/messaging.out'

#Open files into file object variables
f_in = File.open(path_in)
f_out = File.open(path_out, 'w')

#Create instance of KeypadDecoder class
decoder = KeypadDecoder.new
#Run decode_file method of KeypadDeocder instance passing in the open file variables
decoder.decode_file(f_in, f_out)

#Close open files
f_in.close
f_out.close

#output file is decoded message to terminal
puts "File is decoded and saved as messaging.out in the data directory.\n\n"