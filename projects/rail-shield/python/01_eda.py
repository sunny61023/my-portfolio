import pandas as pd
import numpy as np

# RAIL-SHIELD reusable EDA starter
# Replace the sample CSV path with the exported SQL dataset.

df = pd.read_csv("data/journey_segments.csv")

print("Shape:", df.shape)
print("\nMissing values:\n", df.isna().sum())
print("\nDuplicate rows:", df.duplicated().sum())
print("\nData types:\n", df.dtypes)

# Convert timestamps
for col in ["planned_departure","actual_departure","planned_arrival","actual_arrival"]:
    if col in df.columns:
        df[col] = pd.to_datetime(df[col], errors="coerce")

# Feature engineering
if {"planned_arrival","actual_arrival"}.issubset(df.columns):
    df["arrival_delay_minutes"] = (
        (df["actual_arrival"] - df["planned_arrival"])
        .dt.total_seconds() / 60
    ).clip(lower=0)

print("\nDelay summary:")
print(df["arrival_delay_minutes"].describe())

# Operational signal
if "arrival_delay_minutes" in df:
    df["delay_band"] = pd.cut(
        df["arrival_delay_minutes"],
        bins=[-0.01,5,15,30,np.inf],
        labels=["On-time/low","Minor","Moderate","Severe"]
    )

print("\nDelay bands:")
print(df["delay_band"].value_counts(dropna=False))
