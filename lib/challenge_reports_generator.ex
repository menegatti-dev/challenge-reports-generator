defmodule ChallengeReportsGenerator do
  alias ChallengeReportsGenerator.Parser

  @freelancers [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  @months %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }

  @years [
    "2016",
    "2017",
    "2018",
    "2019",
    "2020"
  ]

  # ["Rafael", 7, "9", "8", "2017"],
  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_hours(line, report) end)
  end

  def build_from_many(file_names) when not is_list(file_names) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(file_names) do
    result =
      file_names
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)

    {:ok, result}
  end

  defp sum_reports(
         %{
           "all_hours" => all_hours1,
           "hours_per_month" => hours_per_month1,
           "hours_per_year" => hours_per_year1
         },
         %{
           "all_hours" => all_hours2,
           "hours_per_month" => hours_per_month2,
           "hours_per_year" => hours_per_year2
         }
       ) do
    all_hours = merge_map(all_hours1, all_hours2)
    hours_per_month = merge_maps(hours_per_month1, hours_per_month2)
    hours_per_year = merge_maps(hours_per_year1, hours_per_year2)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp merge_map(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 ->
      Map.merge(value1, value2, fn _key, elem1, elem2 -> elem1 + elem2 end)
    end)
  end

  defp sum_hours([name, hours, _day, moth, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours)

    hours_per_month =
      Map.put(
        hours_per_month,
        name,
        Map.put(
          hours_per_month[name],
          @months[moth],
          hours_per_month[name][@months[moth]] + hours
        )
      )

    hours_per_year =
      Map.put(
        hours_per_year,
        name,
        Map.put(hours_per_year[name], year, hours_per_year[name][year] + hours)
      )

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp report_acc do
    all_hours = Enum.into(@freelancers, %{}, &{&1, 0})

    hours_per_month =
      Enum.into(
        @freelancers,
        %{},
        &{&1, Enum.into(@months, %{}, fn {_key, value} -> {value, 0} end)}
      )

    hours_per_year =
      Enum.into(@freelancers, %{}, &{&1, Enum.into(@years, %{}, fn elem -> {elem, 0} end)})

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
