defmodule Homework.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Companies.Company

  def get_company!(id), do: Repo.get!(Company, id)

  def list_companies(_args) do
    Repo.all(Company)
  end

  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  def get_companies_amount_spent(company_ids) do
    company_ids
    |> Company.companies_query()
    |> Company.companies_available_credit_query()
    |> Repo.all
    |> Enum.into(%{})
  end
end