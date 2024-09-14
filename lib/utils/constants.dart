final Map<String, String> marketsCountry = {
  'TH': 'Thailand',
  'US': 'United States',
  'SG': 'Singapore',
  'VN': 'Vietnam',
  'HK': 'Hong Kong',
  'UK': 'United Kingdom',
  'JP': 'Japan',
  'CN': 'China',
  'TW': 'Taiwan',
  'IN': 'India',
  'AU': 'Australia',
  'DE': 'Germany',
  'CA': 'Canada',
  'FR': 'France',
  'KR': 'South Korea',
  'RU': 'Russia'
};
final Map<String?, String> sector = {
  null: "All sector",
  "CONSUMER_DISCRETIONARY": "Consumer discretionary",
  "CONSUMER_STAPLES": "Consumer staples",
  "ENERGY": "Energy",
  "FINANCIALS": "Financials",
  "HEALTHCARE": "Healthcare",
  "INDUSTRIALS": "Industrials",
  "INFORMATION_TECHNOLOGY": "Information technology",
  "MATERIALS": "Materials",
  "REAL_ESTATE": "Real estate",
  "TELECOMMUNICATION_SERVICES": "Communication services",
  "UTILITIES": "Utilities"
};

const String sectorsQuery = """
        query sectors {
          listJittaSectorType {
            name
          }
        }
      """;

const String stockQuery = '''
          query stockByRanking(\$market: String!, \$sectors: [String], \$page: Int, \$limit: Int) {
            jittaRanking(filter: { market: \$market, sectors: \$sectors, page: \$page, limit: \$limit }) {
              count
              data {
                id
                stockId
                rank
                symbol
                exchange
                title
                jittaScore
                nativeName
                sector {
                  id
                  name
                }
                industry
              }
            }
            listJittaSectorType {
              id
              name
            }
          }
        ''';
const stockDefault = '''
          query stockSummaryQuery(\$stockId: Int, \$id: String) {
            stock(stockId: \$stockId, id: \$id) {
              __typename
              isFollowing
              id
              stockId
              alias
              symbol
              title
              summary
              sector {
                id
                name
              }
              company {
                ipo_date
              }
              market
              industry
              exchange
              currency
              currency_sign
              price_currency
              status
              last_complete_statement_key
              loss_chance {
                last
                updatedAt
              }
              price {
                latest {
                  close
                  datetime
                }
              }
              nativeName
              name
              comparison {
                market {
                  rank
                  member
                }
              }
              updatedFinancialComplete
              company {
                link {
                  url
                }
              }
              jitta {
                priceDiff {
                  last {
                    id
                    value
                    ... on PriceDiffItem {
                      type
                      percent
                    }
                  }
                  values(filterBy: { limit: 132, sort: DESC }) {
                    id
                    value
                    ... on PriceDiffItem {
                      type
                      percent
                    }
                  }
                }
                monthlyPrice {
                  last {
                    id
                    value
                  }
                  total
                  values(filterBy: { limit: 132, sort: ASC }) {
                    id
                    value
                    year
                    month
                  }
                }
                score {
                  last {
                    value
                    id
                  }
                  values(filterBy: { limit: 132, sort: DESC }) {
                    id
                    value
                    quarter
                    year
                  }
                }
                line {
                  total
                  values(filterBy: { limit: 132, sort: DESC }) {
                    id
                    value
                    year
                    month
                  }
                }
                factor {
                  last {
                    value {
                      growth {
                        value
                        name
                        level
                      }
                      recent {
                        value
                        name
                        level
                      }
                      financial {
                        value
                        name
                        level
                      }
                      return {
                        value
                        name
                        level
                      }
                      management {
                        value
                        name
                        level
                      }
                    }
                  }
                }
                sign {
                  last {
                    title
                    type
                    name
                    value
                    display {
                      __typename
                      ... on DisplayIPO {
                        title
                        value
                      }
                      ... on DisplayTable {
                        title
                        columnHead
                        columns {
                          name
                          data
                        }
                        footer
                      }
                    }
                  }
                }
              }
            }
          }
        ''';
const String stockDetalQuery = '''
          query stockSummaryQuery(\$stockId: Int, \$id: String) {
            stock(stockId: \$stockId, id: \$id) {
              __typename
              isFollowing
              id
              stockId
              alias
              symbol
              title
              summary
              sector {
                id
                name
              }
              company {
                ipo_date
              }
              market
              industry
              exchange
              currency
              currency_sign
              price_currency
              status
              last_complete_statement_key
              price {
                latest {
                  close
               
                }
              }
              nativeName
              name
              comparison {
                market {
                  rank
                  member
                }
              }
              company {
                link {
                  url
                }
              }
              jitta {
                priceDiff {
                  last {
                    id
                    value
                    ... on PriceDiffItem {
                      type
                      percent
                    }
                  }
                  values(filterBy: { limit: 132, sort: DESC }) {
                    id
                    value
                    ... on PriceDiffItem {
                      type
                      percent
                    }
                  }
                }
                monthlyPrice {
                  last {
                    id
                    value
                  }
                  total
                  values(filterBy: { limit: 132, sort: ASC }) {
                    id
                    value
                    year
                    month
                  }
                }
                score {
                  last {
                    value
                    id
                  }
                  values(filterBy: { limit: 132, sort: DESC }) {
                    id
                    value
                    quarter
                    year
                  }
                }
                line {
                  total
                  values(filterBy: { limit: 132, sort: DESC }) {
                    id
                    value
                    year
                    month
                  }
                }
                factor {
                  last {
                    value {
                      growth {
                        value
                        name
                        level
                      }
                      recent {
                        value
                        name
                        level
                      }
                      financial {
                        value
                        name
                        level
                      }
                      return {
                        value
                        name
                        level
                      }
                      management {
                        value
                        name
                        level
                      }
                    }
                  }
                }
                sign {
                  last {
                    title
                    type
                    name
                    value
                    display {
                      __typename
                      ... on DisplayIPO {
                        title
                        value
                      }
                      ... on DisplayTable {
                        title
                        columnHead
                        columns {
                          name
                          data
                        }
                        footer
                      }
                    }
                  }
                }
              }
            }
          }
        ''';
