import matplotlib.pyplot as plt
import numpy as np

# === Настройки ===
quadrants = ["Languages & Frameworks", "Tools", "Platforms", "Methods"]
angles = [n / 4.0 * 2 * np.pi for n in range(4)]
angles += angles[:1]  # Замыкаем круг

# Кольца: расстояние от центра
radii = {"Adopt": 1, "Trial": 2, "Assess": 3, "Hold": 4}
colors = {
    "Adopt": "#5ba352",  # Зелёный
    "Trial": "#d6b656",  # Жёлтый
    "Assess": "#bb8b2f",  # Оранжевый
    "Hold": "#e05d44",  # Красный
}

# === Все технологии из tech-radar.md ===
data = [
    # --- Languages & Frameworks ---
    ("Python", 0, "Adopt"),
    ("Go", 0, "Adopt"),
    ("React", 0, "Adopt"),
    ("TypeScript", 0, "Adopt"),
    ("C#", 0, "Trial"),
    # --- Tools ---
    ("Terraform", 1, "Adopt"),
    ("Kafka", 1, "Adopt"),
    ("Grafana + Prometheus", 1, "Adopt"),
    ("GitLab CI / GitHub Actions", 1, "Adopt"),
    ("Airflow", 1, "Trial"),
    ("Schema Registry", 1, "Trial"),
    # --- Platforms ---
    ("Yandex Cloud", 2, "Adopt"),
    ("S3-совместимое хранилище", 2, "Adopt"),
    ("PostgreSQL", 2, "Adopt"),
    ("Kubernetes (Yandex Managed)", 2, "Trial"),
    ("ClickHouse", 2, "Trial"),
    ("DataHub", 2, "Trial"),
    ("Data Lakehouse", 2, "Assess"),
    # --- Methods ---
    ("Event-Driven Architecture", 3, "Adopt"),
    ("DDD", 3, "Adopt"),
    ("IaC", 3, "Adopt"),
    ("Microservices", 3, "Adopt"),
    ("Data Mesh", 3, "Trial"),
    ("Self-service BI", 3, "Trial"),
    ("Apache Camel", 3, "Hold"),
    ("SQL Server 2008", 3, "Hold"),
]

# === Визуализация ===
plt.figure(figsize=(14, 14), dpi=150)
ax = plt.subplot(111, polar=True)

# Смещение для избежания наложения меток
offset_angle = 0.15
label_offset_radius = 0.18

for name, quad, ring in data:
    angle = angles[quad]
    radius = radii[ring]

    # Смещаем метки по углу, чтобы не накладывались
    if "Adopt" in ring:
        angle += offset_angle
    elif "Trial" in ring:
        angle -= offset_angle
    elif "Assess" in ring:
        angle += offset_angle * 0.5
    else:
        angle -= offset_angle * 0.5

    # Основная точка
    ax.scatter(
        angles[quad], radius, color=colors[ring], s=120, edgecolor="black", zorder=5
    )

    # Подпись
    ha = "left" if angle < np.pi else "right"
    ax.text(
        angle,
        radius + label_offset_radius,
        name,
        fontsize=9,
        ha=ha,
        va="bottom",
        bbox=dict(
            boxstyle="round,pad=0.2",
            facecolor=colors[ring],
            alpha=0.7,
            edgecolor="gray",
        ),
        zorder=6,
    )

# === Оформление осей ===
ax.set_xticks(angles[:-1])
ax.set_xticklabels(quadrants, fontsize=12, fontweight="bold")
ax.set_yticks([1, 2, 3, 4])
ax.set_yticklabels(["Adopt", "Trial", "Assess", "Hold"], fontsize=10)
ax.set_ylim(0, 4.8)

# Убираем радиальные линии
ax.set_rgrids([1, 2, 3, 4], angle=0, fontsize=10, color="gray", alpha=0.5)
ax.spines["polar"].set_visible(False)

# === Легенда ===
legend_elements = [
    plt.Line2D(
        [0],
        [0],
        marker="o",
        color="w",
        markerfacecolor=colors["Adopt"],
        label="Adopt",
        markersize=10,
        markeredgecolor="black",
    ),
    plt.Line2D(
        [0],
        [0],
        marker="o",
        color="w",
        markerfacecolor=colors["Trial"],
        label="Trial",
        markersize=10,
        markeredgecolor="black",
    ),
    plt.Line2D(
        [0],
        [0],
        marker="o",
        color="w",
        markerfacecolor=colors["Assess"],
        label="Assess",
        markersize=10,
        markeredgecolor="black",
    ),
    plt.Line2D(
        [0],
        [0],
        marker="o",
        color="w",
        markerfacecolor=colors["Hold"],
        label="Hold",
        markersize=10,
        markeredgecolor="black",
    ),
]
plt.legend(
    handles=legend_elements,
    loc="upper right",
    bbox_to_anchor=(1.3, 1.0),
    fontsize=10,
    title="Status",
    title_fontsize=11,
)

# === Заголовок ===
plt.title(
    "Tech Radar — «Будущее 2.0»\nЦелевой технологический стек",
    size=18,
    weight="bold",
    pad=40,
)

# Сохраняем и показываем
plt.tight_layout()
plt.savefig("tech-radar.png", dpi=150, bbox_inches="tight")
plt.show()

print("✅ Технический радар сохранён как 'tech-radar.png'")
