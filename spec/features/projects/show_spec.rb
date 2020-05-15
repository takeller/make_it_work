require "rails_helper"

describe "When I visit project's show page" do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create!(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  it "can see the project's name, material, and theme" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("News Chic")
    expect(page).to have_content("Material: Newspaper")
    expect(page).to have_content("Challenge Theme: Recycled Material")

    visit "/projects/#{@lit_fit.id}"

    expect(page).to have_content("Litfit")
    expect(page).to have_content("Material: Lamp")
    expect(page).to have_content("Challenge Theme: Apartment Furnishings")
  end

  it "can see a count of the number of contestants working on this project" do
    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Number of Contestants: 2")

    visit "/projects/#{@lit_fit.id}"
    expect(page).to have_content("Number of Contestants: 0")

    visit "/projects/#{@boardfit.id}"
    expect(page).to have_content("Number of Contestants: 2")
  end

  it "can see the average years of experience for contestants on this project" do
    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Average Contestant Experience: 12.5")

    visit "/projects/#{@lit_fit.id}"
    expect(page).to have_content("Average Contestant Experience: 0")

    visit "/projects/#{@boardfit.id}"
    expect(page).to have_content("Average Contestant Experience: 11.5")
  end

  describe "will show new projects added from project show page" do
    it "can add a contestant to a project" do
      visit "/projects/#{@news_chic.id}"

      fill_in :contestant_id, with: "#{@erin.id}"
      click_on "Add Contestant To Project"

      expect(current_path).to eq("/projects/#{@news_chic.id}")
      expect(page).to have_content("Number of Contestants: 3")

    end
  end
end
