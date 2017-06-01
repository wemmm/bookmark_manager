feature 'adding tags' do
  scenario 'has tag field' do
    visit('links/new')
    expect(page.status_code).to eq 200
    expect(page).to have_field('tag_name')
    fill_in 'title', with: 'duckduckgo'
    fill_in 'url', with: 'www.duckduckgo.com'
    fill_in 'tag_name', with: 'Amazing'
    click_button('Submit')
    expect(page).to have_content('Amazing')
  end
end
