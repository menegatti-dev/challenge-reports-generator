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
