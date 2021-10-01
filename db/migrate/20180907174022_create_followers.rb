# frozen_string_literal: true

class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.references :user, foreign_key: true
      t.references :follower

      t.timestamps
    end
  end
end
