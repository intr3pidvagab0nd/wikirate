# -*- encoding : utf-8 -*-

class ChosenStyle < Card::Migration
  def up
    create_or_update name: 'chosen style',
                     type_id: Card::ScssID,
                     codename: 'chosen_style'
  end
end
