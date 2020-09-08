defmodule OnlineBookStore.UserSchemaTest do
  use OnlineBookStore.DataCase

  alias OnlineBookStore.UserSchema

  describe "user" do
    alias OnlineBookStore.UserSchema.User

    @valid_attrs %{address: "some address", first_name: "some first_name", last_name: "some last_name", phone: "some phone"}
    @update_attrs %{address: "some updated address", first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, first_name: nil, last_name: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserSchema.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert UserSchema.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert UserSchema.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = UserSchema.create_user(@valid_attrs)
      assert user.address == "some address"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserSchema.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = UserSchema.update_user(user, @update_attrs)
      assert user.address == "some updated address"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = UserSchema.update_user(user, @invalid_attrs)
      assert user == UserSchema.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = UserSchema.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserSchema.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = UserSchema.change_user(user)
    end
  end
end
