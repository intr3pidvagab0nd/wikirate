#!/usr/bin/env ruby
require File.expand_path('../../config/environment',  __FILE__)
Card::Auth.as_bot

card = Card["*read"]
klasses = Card.set_patterns.reverse.map do |set_class|
  wql = { :left  => { :type =>Card::SetID },
  :right => card.id,
          #:sort  => 'content',
          
          :sort  => ['content', 'name'],
          :limit => 0
        }
  wql[:left][ (set_class.anchorless? ? :id : :right_id )] = set_class.pattern_id

  rules = Card.search wql
  [ set_class, rules ] unless rules.empty?
end.compact

klasses.map do |klass, rules|

  unless klass.anchorless?
    previous_content = nil
    rules.map do |rule|
      current_content = rule.content.strip
      duplicate = previous_content == current_content
      changeover = previous_content && !duplicate
      previous_content = current_content

      puts "#{klass}:#{rule.name}(#{rule.item_names} #{Card[rule.left.left.type_id].codename})" if !rule.item_names.include? "Anyone"
      if !rule.name.include? "*email+*right"
        if !rule.item_names.include? "Anyone"
          #rule.delete!
          puts "#{rule.name} with permission only for #{rule.item_names} is deleted." 
        end
        if !Card[rule.left.left.type_id].codename
          #Card[rule.left.left.type_id].delete!
          puts "Cardtype: #{Card[rule.left.left.type_id].name} is deleted."
        end
      end
    end

  end
end
