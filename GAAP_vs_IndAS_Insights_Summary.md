# US GAAP vs Ind AS: Cross-Standard Financial Statement Analysis
## Hindustan Unilever Ltd (Ind AS) vs Procter & Gamble Co (US GAAP), FY2021–FY2025

**Tools used:** SQL (MySQL — schema design, CTEs, window functions) · Advanced Excel (formula-driven ratio models)
**Data sources:** HUL consolidated annual reports (BSE/NSE filings); P&G Form 10-K filings (SEC EDGAR)

---

## Project Summary

This project compares the financial performance and reporting practices of two large FMCG companies operating under different accounting standards — Hindustan Unilever under Ind AS (India) and Procter & Gamble under US GAAP — over a 5-year period. Rather than restating one company's numbers into the other's standard, the analysis keeps each company in its native currency and standard, comparing shape (margins, ratios, growth rates) rather than absolute scale, and separately documents where the two standards genuinely diverge versus where they've converged in practice.

## Methodology

1. **Data Collection** — Consolidated Income Statement, Balance Sheet, and Cash Flow data for both companies, FY2021–FY2025, sourced directly from each company's primary filings.
2. **Database Design** — Built a normalized SQL schema (`companies`, `financial_data`, `standards_differences`) so the same dataset could be queried relationally rather than only viewed as a spreadsheet.
3. **Ratio Analysis** — Computed 9 ratios per company per year in Excel (formula-driven, auditable) and independently replicated the same ratio panel in SQL using CTEs and pivoted `CASE` aggregation, cross-checking both outputs matched.
4. **Standards Research** — Researched and documented 5 specific US GAAP vs Ind AS divergence points relevant to FMCG accounting (revenue recognition, inventory valuation, leases, PP&E, goodwill), citing each company's actual disclosed accounting policy rather than assuming standard defaults.

## Key Findings

**Growth**
- HUL's revenue grew from ₹47,028 Cr to ₹61,328 Cr, a 6.9% 4-year CAGR — notably faster than P&G's, which grew from $76,118M to $84,284M, a 2.6% CAGR.
- P&G's growth is more margin-led: gross margin expanded from ~51% to ~51% (broadly stable, with a step-up in FY24), while operating margin rose from ~23.6% to ~24.3%.

**Profitability**
- Both companies' net margins sit in a similar band (HUL ~16.6–17.4%, P&G ~17.7–18.9%), despite very different market structures — India's domestic FMCG market for HUL vs. P&G's global multi-category footprint.
- HUL's Return on Equity (ROE) ranges 16.8%–21.6%, meaningfully lower than P&G's 30–33% range — largely because P&G carries far more leverage relative to its equity base.

**Leverage — the sharpest contrast**
- Debt-to-Equity: HUL ranges 0.44x–0.62x, while P&G ranges 1.40x–1.57x. HUL is essentially debt-free by policy; P&G's capital structure relies much more heavily on debt financing, inflating its ROE relative to HUL's more conservative balance sheet.

**Cash Flow**
- HUL's FCF margin jumped sharply in FY24 (to ~22.6%) on a working-capital swing before normalizing; P&G's FCF margin held a steadier 16.6%–20.5% band across all 5 years, reflecting its larger, more mature cash-generation base.

## Standards Comparison — What Actually Diverges

| Topic | Divergence in practice |
|---|---|
| Revenue Recognition | Minimal — both ASC 606 and Ind AS 115 are IFRS-15-based and substantially converged. |
| Inventory Valuation | Smaller than expected — P&G's 10-K confirms it uses primarily FIFO (like HUL must under Ind AS 2), with only minor LIFO use; the standards permit more divergence than either company actually exercises. |
| Lease Accounting | Minimal — ASC 842 and Ind AS 116 use the same core on-balance-sheet lessee model since 2019. |
| PP&E | Real potential divergence — Ind AS 16 permits a revaluation model that US GAAP prohibits outright; this is the clearest standards-driven gap, though it depends on which model HUL elects. |
| Goodwill | Minimal — both standards test for impairment annually rather than amortizing, post-convergence. |

**The core insight**: the popular assumption that "US GAAP and Ind AS produce very different numbers" holds far less than expected for a mature, converged area like FMCG accounting. Most of the real divergence between HUL and P&G's financials traces to genuine business and capital-structure differences (leverage, market maturity, growth stage) — not accounting standard choice.

## Project Artifacts

| Artifact | Contents |
|---|---|
| Excel workbook | Raw_Data_HUL, Raw_Data_PG, Ratios_Comparison, Standards_Differences sheets |
| SQL script | Schema, data load, and 5 analysis queries (pivot, window functions, CTEs, CAGR, standards lookup) |

---
*Prepared by Sri Sai Samarth Sistla as part of a financial analyst portfolio project.*
