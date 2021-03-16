defmodule ChallengeReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "gen_report_test.csv"

      response = ChallengeReportsGenerator.build(file_name)

      expected_response = %{
        "all_hours" => %{
          "Cleiton" => 12,
          "Daniele" => 21,
          "Danilo" => 7,
          "Diego" => 12,
          "Giuliano" => 14,
          "Jakeliny" => 22,
          "Joseph" => 13,
          "Mayk" => 19,
          "Rafael" => 7,
          "Vinicius" => 0
        },
        "hours_per_month" => %{
          "Cleiton" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 4,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 8,
            "setembro" => 0
          },
          "Daniele" => %{
            "abril" => 7,
            "agosto" => 0,
            "dezembro" => 5,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 1,
            "maio" => 8,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Danilo" => %{
            "abril" => 1,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 6,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Diego" => %{
            "abril" => 4,
            "agosto" => 4,
            "dezembro" => 1,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 3
          },
          "Giuliano" => %{
            "abril" => 1,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 9,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 4,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Jakeliny" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 8,
            "junho" => 0,
            "maio" => 0,
            "março" => 14,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Joseph" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 2,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 3,
            "novembro" => 5,
            "outubro" => 0,
            "setembro" => 3
          },
          "Mayk" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 5,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 7,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 7
          },
          "Rafael" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 7,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Vinicius" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          }
        },
        "hours_per_year" => %{
          "Cleiton" => %{"2016" => 3, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 9},
          "Daniele" => %{"2016" => 10, "2017" => 3, "2018" => 7, "2019" => 0, "2020" => 1},
          "Danilo" => %{"2016" => 0, "2017" => 0, "2018" => 1, "2019" => 6, "2020" => 0},
          "Diego" => %{"2016" => 3, "2017" => 8, "2018" => 0, "2019" => 1, "2020" => 0},
          "Giuliano" => %{"2016" => 0, "2017" => 3, "2018" => 0, "2019" => 6, "2020" => 5},
          "Jakeliny" => %{"2016" => 8, "2017" => 8, "2018" => 0, "2019" => 6, "2020" => 0},
          "Joseph" => %{"2016" => 0, "2017" => 3, "2018" => 0, "2019" => 3, "2020" => 7},
          "Mayk" => %{"2016" => 7, "2017" => 8, "2018" => 0, "2019" => 4, "2020" => 0},
          "Rafael" => %{"2016" => 0, "2017" => 7, "2018" => 0, "2019" => 0, "2020" => 0},
          "Vinicius" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0}
        }
      }

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "builds the report from many files" do
      file_name = ["gen_report_test.csv", "gen_report_test.csv", "gen_report_test.csv"]

      response = ChallengeReportsGenerator.build_from_many(file_name)

      expected_response =
        {:ok,
         %{
           "all_hours" => %{
             "Cleiton" => 36,
             "Daniele" => 63,
             "Danilo" => 21,
             "Diego" => 36,
             "Giuliano" => 42,
             "Jakeliny" => 66,
             "Joseph" => 39,
             "Mayk" => 57,
             "Rafael" => 21,
             "Vinicius" => 0
           },
           "hours_per_month" => %{
             "Cleiton" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 12,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 24,
               "setembro" => 0
             },
             "Daniele" => %{
               "abril" => 21,
               "agosto" => 0,
               "dezembro" => 15,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 3,
               "maio" => 24,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Danilo" => %{
               "abril" => 3,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 18,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Diego" => %{
               "abril" => 12,
               "agosto" => 12,
               "dezembro" => 3,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 9
             },
             "Giuliano" => %{
               "abril" => 3,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 27,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 12,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Jakeliny" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 24,
               "junho" => 0,
               "maio" => 0,
               "março" => 42,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Joseph" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 6,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 9,
               "novembro" => 15,
               "outubro" => 0,
               "setembro" => 9
             },
             "Mayk" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 15,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 21,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 21
             },
             "Rafael" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 21,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Vinicius" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             }
           },
           "hours_per_year" => %{
             "Cleiton" => %{"2016" => 9, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 27},
             "Daniele" => %{"2016" => 30, "2017" => 9, "2018" => 21, "2019" => 0, "2020" => 3},
             "Danilo" => %{"2016" => 0, "2017" => 0, "2018" => 3, "2019" => 18, "2020" => 0},
             "Diego" => %{"2016" => 9, "2017" => 24, "2018" => 0, "2019" => 3, "2020" => 0},
             "Giuliano" => %{"2016" => 0, "2017" => 9, "2018" => 0, "2019" => 18, "2020" => 15},
             "Jakeliny" => %{"2016" => 24, "2017" => 24, "2018" => 0, "2019" => 18, "2020" => 0},
             "Joseph" => %{"2016" => 0, "2017" => 9, "2018" => 0, "2019" => 9, "2020" => 21},
             "Mayk" => %{"2016" => 21, "2017" => 24, "2018" => 0, "2019" => 12, "2020" => 0},
             "Rafael" => %{"2016" => 0, "2017" => 21, "2018" => 0, "2019" => 0, "2020" => 0},
             "Vinicius" => %{"2016" => 0, "2017" => 0, "2018" => 0, "2019" => 0, "2020" => 0}
           }
         }}

      assert response == expected_response
    end
  end
end
