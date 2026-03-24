defmodule Toilets.Bathrooms do
  @moduledoc """
  The Toilets/ Bathroom context.
  """

  import Ecto.Query, warn: false
  alias Toilets.Repo
  alias Toilets.Bathrooms.Toilet

  @doc """
  Registers a toilet.

  ## Examples

      iex> list_toilet(%{field: value})
      {:ok, %Toilet{}}

      iex> list_toilet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def list_toilet(attrs) do
    %Toilet{}
    |> Toilet.create_toilet_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking toilet changes.

  ## Examples

      iex> change_toilet_registration(toilet)
      %Ecto.Changeset{data: %Toilet{}}

  """
  def change_create_toilet_registration(%Toilet{} = toilet, attrs \\ %{}) do
    Toilet.create_toilet_changeset(toilet, attrs)
  end

  @doc """
  Gets all toilets.

  Raises `Ecto.QueryError` if query validation fails..

  ## Examples

      iex> all_toilets()
      %User{}

      iex> all_toilets()
      ** (Ecto.QueryError)

  """
  def all_toilets() do
    Repo.all(Toilet) 
  end
end
