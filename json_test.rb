
adwords_report = {"report": {
    "table": {
      "columns": {
        "column": [
          {
            "name": "adGroup",
            "display": "Ad group"
          },
          {
            "name": "adGroupID",
            "display": "Ad group ID"
          },
          {
            "name": "impressions",
            "display": "Impressions"
          },
          {
            "name": "clicks",
            "display": "Clicks"
          },
          {
            "name": "cost",
            "display": "Cost"
          },
          {
            "name": "avgCPC",
            "display": "Avg. CPC"
          },
          {
            "name": "avgPosition",
            "display": "Avg. position"
          },
          {
            "name": "day",
            "display": "Day"
          }
        ]
      },
      "row": [
        {
          "adGroup": "Lentes de contacto",
          "adGroupID": "22776661137",
          "impressions": "952",
          "clicks": "42",
          "cost": "403730000",
          "avgCPC": "9612619",
          "avgPosition": "1.5",
          "day": "2016-09-08"
        },
        {
          "adGroup": "Lentes de contacto",
          "adGroupID": "22776661137",
          "impressions": "906",
          "clicks": "43",
          "cost": "448920000",
          "avgCPC": "10440000",
          "avgPosition": "1.5",
          "day": "2016-09-09"
        },
        {
          "adGroup": "Lentes de contacto",
          "adGroupID": "22776661137",
          "impressions": "813",
          "clicks": "44",
          "cost": "422360000",
          "avgCPC": "9599091",
          "avgPosition": "1.4",
          "day": "2016-09-10"
        },
        {
          "adGroup": "Lentes de contacto",
          "adGroupID": "22776661137",
          "impressions": "799",
          "clicks": "37",
          "cost": "394590000",
          "avgCPC": "10664595",
          "avgPosition": "1.5",
          "day": "2016-09-11"
        },
        {
          "adGroup": "Lentes de contacto",
          "adGroupID": "22776661137",
          "impressions": "361",
          "clicks": "37",
          "cost": "467380000",
          "avgCPC": "12631892",
          "avgPosition": "1.4",
          "day": "2016-09-12"
        },
        {
          "adGroup": "Lentes de contacto",
          "adGroupID": "22776661137",
          "impressions": "923",
          "clicks": "42",
          "cost": "443650000",
          "avgCPC": "10563095",
          "avgPosition": "1.5",
          "day": "2016-09-13"
        }
      ]
    }
  }
}

impressions = []
clicks = []
cost = []
dates = []

adwords_report[:report][:table][:row].each do |x|
    

    impressions.push(x[:impressions])
    clicks.push(x[:clicks])
    cost.push(x[:cost])
    dates.push(x[:day])
  end

puts impressions
puts clicks
puts cost
puts dates


dates.each do | day |
          "#{day},"
        end



