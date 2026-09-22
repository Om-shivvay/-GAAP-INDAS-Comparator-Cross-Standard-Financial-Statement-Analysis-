# GAAP-IndAS Comparator
### Cross-Standard Financial Statement Analysis — Hindustan Unilever (Ind AS) vs Procter & Gamble (US GAAP)

A financial analyst portfolio project comparing the reported financial performance of two large FMCG companies operating under different accounting standards — Hindustan Unilever (India, Ind AS) and Procter & Gamble (USA, US GAAP) — across FY2021–FY2025. The project quantifies where the two companies' financials genuinely diverge due to business/capital-structure differences, and separately documents where US GAAP and Ind AS have actually converged versus where real accounting-standard differences remain.

## Tools Used
- **SQL (MySQL)** — schema design, CTEs, window functions
- **Advanced Excel** — Power Query-style structured data, formula-driven ratio models

## Project Structure
```
├── US_GAAP_vs_IndAS_HUL_PG_Analysis.xlsx   # Excel workbook
├── gaap_vs_indas_analysis.sql              # SQL schema, data load, and analysis queries
├── GAAP_vs_IndAS_Insights_Summary.md       # Written findings and interpretation
└── README.md
```

## Excel Workbook
| Sheet | Contents |
|---|---|
| `Raw_Data_HUL` | HUL Income Statement, Balance Sheet, Cash Flow — FY2021–FY2025, ₹ Crores (Ind AS) |
| `Raw_Data_PG` | P&G Income Statement, Balance Sheet, Cash Flow — FY2021–FY2025, $ Millions (US GAAP) |
| `Ratios_Comparison` | 9 ratios (liquidity, profitability, leverage, efficiency, cash flow) computed independently per company, formula-linked to raw data |
| `Standards_Differences` | Reference table covering 5 US GAAP vs Ind AS divergence points relevant to FMCG accounting |

## SQL Analysis
The SQL script builds a normalized schema (`companies`, `financial_data`, `standards_differences`) and includes 5 analysis queries:
1. Side-by-side Revenue & Net Profit pivot across both companies
2. YoY Revenue Growth % using the `LAG()` window function
3. Full ratio panel (Current Ratio, Net Margin, ROA, ROE, Debt-to-Equity, FCF Margin) via CTE-based pivoting
4. 5-Year Revenue CAGR comparison
5. Standards-differences reference lookup

Written for MySQL 8.0+; logic validated end-to-end before delivery.

## Methodology
1. Sourced consolidated financial statements directly from each company's primary filings (HUL annual reports; P&G 10-K via SEC EDGAR).
2. Kept each company in its native currency and accounting standard — ratios and growth rates are compared in shape, not absolute scale, to avoid FX-conversion assumptions distorting the analysis.
3. Built the same ratio panel independently in both Excel (formulas) and SQL (CTEs), cross-checking that both outputs matched.
4. Researched each company's actual disclosed accounting policy (e.g., P&G's 10-K inventory footnote) rather than assuming standard defaults, to separate real divergence from theoretical divergence.

## Key Findings
- **Growth**: HUL revenue grew at a 6.9% 4-year CAGR vs. P&G's 2.6% — HUL's growth is faster; P&G's is more margin-led (operating margin ~23.6% → ~24.3%).
- **Profitability**: Net margins are similar in band (HUL ~16.6–17.4%, P&G ~17.7–18.9%), but ROE diverges sharply (HUL ~17–22% vs. P&G ~31–33%) due to leverage, not core profitability.
- **Leverage**: HUL runs at 0.44x–0.62x Debt-to-Equity (near debt-free by policy); P&G runs at 1.40x–1.57x — the single biggest structural difference between the two companies.
- **Cash Flow**: P&G's FCF margin is steadier (16.6%–20.5% across all 5 years) than HUL's, which spiked in FY24 on a working-capital swing.
- **Standards convergence**: Revenue recognition, lease accounting, and goodwill treatment are all substantially converged between US GAAP and Ind AS post-2018. Inventory valuation diverges less in practice than the standards permit, since P&G's own 10-K confirms primarily FIFO use. PP&E revaluation (permitted under Ind AS 16, prohibited under US GAAP) remains the clearest standards-driven gap.

**Bottom line**: most of the real difference between HUL's and P&G's financials traces to business maturity and capital-structure choices — not accounting standard selection.

## Author
Sri Sai Samarth Sistla — [LinkedIn](https://linkedin.com/in/sri-sai-samarth-sistla-532657258) · [GitHub](https://github.com/Om-shivvay)
