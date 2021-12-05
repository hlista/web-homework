defmodule HomeworkWeb.Schemas.CompaniesSchema do
  @moduledoc """
  Defines the graphql schema for merchants.
  """
  use Absinthe.Schema.Notation

  alias HomeworkWeb.Resolvers.CompaniesResolver

  object :company do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:credit_line, :integer)
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)

    field(:available_credit, :integer) do
      resolve fn company, _, _->
        batch({CompaniesResolver, :companies_amount_spent}, company.id, fn batch_results ->
          {:ok, company.credit_line - Map.get(batch_results, company.id, 0)}
        end)
      end
    end
  end

  object :company_mutations do
    @desc "Create a new company"
    field :create_company, :company do
      arg(:name, non_null(:string))
      arg(:credit_line, non_null(:integer))

      resolve(&CompaniesResolver.create_company/3)
    end

    @desc "Update a new company"
    field :update_company, :company do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      arg(:credit_line, non_null(:integer))

      resolve(&CompaniesResolver.update_company/3)
    end

    @desc "delete an existing company"
    field :delete_company, :company do
      arg(:id, non_null(:id))

      resolve(&CompaniesResolver.delete_company/3)
    end
  end
end