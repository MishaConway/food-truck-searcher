defmodule FoodTruckSearcher.FoodTrucks.SearchParams do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :search_text, :string
    field :zipcode, :string
    field :include_approved, :boolean
    field :include_not_approved, :boolean
    field :include_truck_category, :boolean
    field :include_push_cart_category, :boolean
  end

  def changeset(schema, attrs) do
    fields = __schema__(:fields)

    cast(schema, attrs, fields)
  end

  def new(attrs \\ {}) do
    include_approved =
      if Map.has_key?(attrs, :include_approved), do: attrs.include_approved, else: true

    include_not_approved =
      if Map.has_key?(attrs, :include_not_approved), do: attrs.include_not_approved, else: true

    include_truck_category =
      if Map.has_key?(attrs, :include_truck_category),
        do: attrs.include_truck_category,
        else: true

    include_push_cart_category =
      if Map.has_key?(attrs, :include_push_cart_category),
        do: attrs.include_push_cart_category,
        else: true

    %__MODULE__{
      search_text: attrs[:search_text] || "",
      zipcode: attrs[:zipcode] || "",
      include_approved: include_approved,
      include_not_approved: include_not_approved,
      include_truck_category: include_truck_category,
      include_push_cart_category: include_push_cart_category
    }
  end
end
