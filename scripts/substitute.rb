#!/usr/bin/ruby

unless ARGV[0] and ARGV[1] and ARGV[2]
    puts "Usage: ruby substitute.rb <file_path> <old_content> <new_content>"
    puts "Example: ruby substitute.rb myfile.txt path/to/file.txt hello hey"
    exit
end
unless File.exist? ARGV[0]
    puts "#{ARGV[0]} does not  exist."
    puts "Please provide the path to the file you want to manipulate."
    exit
end
if File.directory? ARGV[0]
    puts "#{ARGV[0]} is not a file but a directory.\nPlease provide the path to the file you want to manipulate."
    exit
end

file_path=ARGV[0]
old_content=ARGV[1]
new_content=ARGV[2]

file=File.new file_path,"r"
if !file
    puts "Failed to read file "+file_path
else
    content=""
    file.each do |line|
        content<<line
    end
    pattern=content.match /#{old_content}/
    if !pattern
        puts "No match found."
	file.close
	exit
    else
        content=content.gsub(/#{old_content}/,new_content)
    end
end
file.close

file=File.new file_path,"w"
if !file
    puts "Failed to write file "+file_path
else
    file.write content
end
file.close
