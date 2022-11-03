class SessionsView
  def ask_for_stuff(stuff)
    puts "what's the #{stuff}?"
    gets.chomp
  end
end
