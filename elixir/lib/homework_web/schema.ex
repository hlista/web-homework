defmodule HomeworkWeb.Schema do
  @moduledoc """
  Defines the graphql schema for this project.
  """
  use Absinthe.Schema

  alias HomeworkWeb.Resolvers.MerchantsResolver
  alias HomeworkWeb.Resolvers.TransactionsResolver
  alias HomeworkWeb.Resolvers.UsersResolver
  import_types(HomeworkWeb.Schemas.Types)

  query do
    @desc "Get all Transactions"
    field(:transactions, list_of(:transaction)) do
      arg :min, :integer
      arg :max, :integer
      resolve(&TransactionsResolver.transactions/3)
    end

    @desc "Get all Users"
    field(:users, list_of(:user)) do
      arg :first_name, :string
      arg :last_name, :string
      resolve(&UsersResolver.users/3)
    end

    @desc "Get all Merchants"
    field(:merchants, list_of(:merchant)) do
      arg :name, :string
      resolve(&MerchantsResolver.merchants/3)
    end
  end

  mutation do
    import_fields(:transaction_mutations)
    import_fields(:user_mutations)
    import_fields(:merchant_mutations)
  end
end
