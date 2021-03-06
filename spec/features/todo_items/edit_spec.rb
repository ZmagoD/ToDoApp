require 'spec_helper'

describe "Editing todo items" do
    let!(:todo_list){ TodoList.create(title: "Groceries", description: "Grocery list.") }
    let!(:todo_item){ todo_list.todo_items.create(content:"Milk") }
 
    
    it "is successful with valid content" do
        visit_todo_list(todo_list)
        within "#todo_item_#{todo_item.id}" do
            click_link "Edit"
        end
        fill_in "Content", with: "Lot's of milk"
        click_button "Save"
        expect(page).to have_content("Saved todo list item.")
        todo_item.reload
        expect(todo_item.content).to eq("Lot's of milk")
    end
    
    it "is unsuccessful with no content" do
        visit_todo_list(todo_list)
        within "#todo_item_#{todo_item.id}" do
            click_link "Edit"
        end
        fill_in "Content", with: ""
        click_button "Save"
        expect(page).to_not have_content("Saved todo list item.")
        expect(page).to have_content("That todo item could not be saved.")
        todo_item.reload
        expect(todo_item.content).to eq("Milk")
    end
    
    
    it "is unsuccessful with no enought content" do
        visit_todo_list(todo_list)
        within "#todo_item_#{todo_item.id}" do
            click_link "Edit"
        end
        fill_in "Content", with: "1"
        click_button "Save"
        expect(page).to_not have_content("Saved todo list item.")
        expect(page).to have_content("That todo item could not be saved")
        todo_item.reload
        expect(todo_item.content).to eq("Milk")
    end
end