defmodule OnlineBookStore.CategorySchemaTest do
  use OnlineBookStore.DataCase

  alias OnlineBookStore.CategorySchema

  describe "category" do
    alias OnlineBookStore.CategorySchema.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CategorySchema.create_category()

      category
    end

    test "list_category/0 returns all category" do
      category = category_fixture()
      assert CategorySchema.list_category() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert CategorySchema.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = CategorySchema.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CategorySchema.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = CategorySchema.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = CategorySchema.update_category(category, @invalid_attrs)
      assert category == CategorySchema.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = CategorySchema.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> CategorySchema.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = CategorySchema.change_category(category)
    end
  end
end
