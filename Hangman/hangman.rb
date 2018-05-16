
class Hangman
    require 'yaml'
#------------------------------------------------------------------------------------
    def initialize
        @word=random_word 
        @chance= 5 
        @miss=[]
        @correct=[]
        @word_result = "*" * @word.length 
        
    end
#------------------------------------------------------------------------------------
    def save_game
        yaml_file = YAML.dump({
            word: @word, 
            chance: @chance,
            word_result: @word_result,
            miss: @miss,
            correct: @correct
          })
          File.open('save_data.yml', 'w') { |f| f.write yaml_file }
    end

#------------------------------------------------------------------------------------
    def random_word
        array_of_lines = File.readlines("recnik.txt")
        arr=[]
        array_of_lines.each do |x|
          if x.to_s.length > 5 && x.to_s.length < 12 && x==x.downcase
           arr << x
          end
        end
    
        rnumber=rand(arr.length)
        rword=arr[rnumber]
        $rec=rword.split("")
        $rec.delete_at($rec.length-1)
        $rec
    end

#------------------------------------------------------------------------------------    
    def choose_letters
        until win? || @chance==0
            print "Unesite zeljeno slovo?"
            letter= gets.chomp
            until letter.length == 1 
                print "Unesite tacno 1 slovo?"
                letter= gets.chomp
            end
            if @word.include?letter then
                arr_ind=[]
                @word.each_with_index do |val,index|
                    if letter == val then
                        arr_ind << index
                        @correct << val
                    end
                    @word_result.split("")
                    arr_ind.each do |ind|
                        @word_result[ind]=letter
                    end 
           
                end
                
                puts "Mesto za pogadjanje #{@word_result}"
                puts "Trazena rec je #{@word}"

                if win? then
                puts "VICTORY"
                end

        
            else puts "Ne postoji slovo #{letter}"
                @miss << letter
                p @word
                @chance=@chance-1
                puts "Ostalo je #{@chance} pokusaja"
                if @chance==0 then
                    puts "Izgubio si igru"
                end

            end
            puts "Da li zelite da snimite igru ako da onda kucaj yes ako ne enter"
            snimi=gets.chomp
            if snimi == "yes" then
                save_game
                exit

            end
        end

    end
#------------------------------------------------------------------------------------  

    def win?
        if @word_result == @word.join("") then
          return true
        end
    end
#------------------------------------------------------------------------------------  

    def load_game
        file = YAML.load_file('save_data.yml')
        @chance = file[:chance]
        @word = file[:word]
        @miss = file[:miss]
        @correct = file[:correct]
        @word_result = file[:word_result]
        
    end
#------------------------------------------------------------------------------------  

    
end #closing tag for class Hangman


puts "Dobrodosli u igru Hangman, LOAD GAME-> load, NEW GAME-> new"
answer=gets.chomp
if answer=="new" then
    game=Hangman.new
    game.choose_letters
    
elsif answer=="load" then
    puts "Ucitacete staru igru i nastavicete odaklse ste poceli!"
    game=Hangman.new
    puts game.load_game 
    game.choose_letters
end








