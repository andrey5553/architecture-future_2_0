# Каталог доменных событий

## Список событий
| №   | Название события      | Контекст-источник  | Описание                             |
| --- | --------------------- | ------------------ | ------------------------------------ |
| 1   | PatientRegistered     | Patient Management | Пациент зарегистрирован в системе    |
| 2   | MedicalRecordCreated  | Medical Records    | Загружены данные исследования        |
| 3   | AIAnalysisStarted     | AI Diagnostics     | Начат анализ данных ИИ               |
| 4   | AIAnalysisCompleted   | AI Diagnostics     | ИИ завершил анализ                   |
| 5   | DiagnosisFormed       | Medical Records    | Диагноз сформирован (ИИ + врач)      |
| 6   | InvoiceIssued         | Billing            | Сформирован счёт за услугу           |
| 7   | CreditContractCreated | Billing            | Оформлен кредитный договор           |
| 8   | PaymentReceived       | Billing            | Поступила оплата по счёту            |
| 9   | NotificationSent      | Notifications      | Уведомление доставлено               |
| 10  | InfrastructureUpdated | IaC & Operations   | Инфраструктура обновлена через CI/CD |

## Подробное описание событий

1. PatientRegistered — Зарегистрирован новый пациент
Контекст-источник: Patient Management
Семантика: Пациент успешно зарегистрирован. Доступны контактные данные, идентификатор и статус.

Минимальный контракт:
```json
{
  "event_id": "evt-123e4567-e89b-12d3-a456-426614174000",
  "event_type": "PatientRegistered",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:00:00Z",
  "data": {
    "patient_id": "pat-abc123",
    "full_name": "Иванов Иван Иванович",
    "birth_date": "1985-03-20",
    "gender": "male",
    "phone": "+79161234567",
    "email": "ivanov@example.com",
    "external_id": "123-456-789 00",
    "created_at": "2026-15-06T10:00:00Z"
  }
}
```

2. MedicalRecordCreated — Создана медицинская запись
Контекст-источник: Medical Records
Семантика: Исследование (МРТ, ЭКГ и т.д.) загружено. Данные доступны для анализа.

Минимальный контракт:
```json
{
  "event_id": "evt-234e4567-e89b-12d3-a456-426614174001",
  "event_type": "MedicalRecordCreated",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:15:00Z",
  "data": {
    "record_id": "rec-mri-001",
    "patient_id": "pat-abc123",
    "study_type": "MRI",
    "body_part": "brain",
    "input_data_url": "https://storage.yandexcloud.net/medical-data/mri_001.dcm",
    "input_data_hash": "sha256:abc123...",
    "uploaded_by": "device:mri-scanner-01",
    "created_at": "2026-14-06T10:15:00Z"
  }
}
```

3. AIAnalysisStarted — Анализ МРТ запущен
Контекст-источник: AI Diagnostics
Семантика: Система ИИ начала обработку медицинских данных. Готовится к выводу.

Минимальный контракт:
```json
{
  "event_id": "evt-345e4567-e89b-12d3-a456-426614174002",
  "event_type": "AIAnalysisStarted",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:20:00Z",
  "data": {
    "ai_result_id": "ai-001",
    "record_id": "rec-mri-001",
    "model_version": "brain_tumor_v3",
    "started_at": "2026-14-06T10:20:00Z"
  }
}
```

4. AIAnalysisCompleted — Пройдено исследование ИИ
Контекст-источник: AI Diagnostics
Семантика: ИИ завершил анализ. Результат доступен и может быть использован для диагностики.

Минимальный контракт:
```json
{
  "event_id": "evt-456e4567-e89b-12d3-a456-426614174003",
  "event_type": "AIAnalysisCompleted",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:25:00Z",
  "data": {
    "ai_result_id": "ai-001",
    "record_id": "rec-mri-001",
    "model_version": "brain_tumor_v3",
    "output": {
      "tumor_detected": true,
      "location": "frontal_lobe",
      "size_mm": 15.2
    },
    "confidence": 0.97,
    "completed_at": "2026-14-06T10:25:00Z"
  }
}
```

5. DiagnosisFormed — Диагноз сформирован
Контекст-источник: Medical Records
Семантика: Диагноз зафиксирован в карте пациента. Может быть основан на ИИ и/или врачебном осмотре.

Минимальный контракт:
```json
{
  "event_id": "evt-567e4567-e89b-12d3-a456-426614174004",
  "event_type": "DiagnosisFormed",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:30:00Z",
  "data": {
    "diagnosis_id": "dx-001",
    "record_id": "rec-mri-001",
    "patient_id": "pat-abc123",
    "ai_result_id": "ai-001",
    "doctor_id": "doc-007",
    "diagnosis_code": "D33.0",
    "description": "Опухоль лобной доли головного мозга",
    "severity": "high",
    "confirmed_by": "doctor",
    "confirmed_at": "2026-14-06T10:30:00Z"
  }
}
```

6. InvoiceIssued — Счёт выставлен
Контекст-источник: Billing
Семантика: Сформирован счёт за медицинскую услугу. Готов к оплате.

Минимальный контракт:
```json
{
  "event_id": "evt-678e4567-e89b-12d3-a456-426614174005",
  "event_type": "InvoiceIssued",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:35:00Z",
  "data": {
    "invoice_id": "inv-001",
    "patient_id": "pat-abc123",
    "amount": 350000,
    "currency": "RUB",
    "service_type": "MRI",
    "record_id": "rec-mri-001",
    "due_date": "2026-14-06T23:59:59Z",
    "status": "issued",
    "issued_at": "2026-14-06T10:35:00Z"
  }
}
```

7. CreditContractCreated — Создан кредитный договор
Контекст-источник: Billing
Семантика: Оформлен договор на получение кредита для оплаты медицинской услуги.
Минимальный контракт:

```json
{
  "event_id": "evt-789e4567-e89b-12d3-a456-426614174006",
  "event_type": "CreditContractCreated",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:40:00Z",
  "data": {
    "contract_id": "cr-001",
    "patient_id": "pat-abc123",
    "loan_amount": 10000000,
    "currency": "RUB",
    "term_months": 12,
    "interest_rate": 0.0,
    "monthly_payment": 833333,
    "repayment_schedule": [
      { "month": 1, "due_date": "2026-15-05", "amount": 833333 },
      { "month": 2, "due_date": "2026-16-05", "amount": 833333 }
    ],
    "status": "active",
    "created_at": "2026-14-06T10:40:00Z"
  }
}
```

8. PaymentReceived — Оплата получена
Контекст-источник: Billing
Семантика: Поступила оплата по счёту. Статус счёта может быть обновлён.

Минимальный контракт:
```json
{
  "event_id": "evt-890e4567-e89b-12d3-a456-426614174007",
  "event_type": "PaymentReceived",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:45:00Z",
  "data": {
    "payment_id": "pay-001",
    "invoice_id": "inv-001",
    "patient_id": "pat-abc123",
    "amount": 350000,
    "currency": "RUB",
    "payment_method": "card",
    "transaction_id": "txn-12345",
    "processed_at": "2026-14-06T10:45:00Z"
  }
}
```

9. NotificationSent — Уведомление отправлено
Контекст-источник: Notifications
Семантика: Пациенту или врачу отправлено уведомление (email, SMS, push).

Минимальный контракт:
```json
{
  "event_id": "evt-901e4567-e89b-12d3-a456-426614174008",
  "event_type": "NotificationSent",
  "version": "1.0",
  "occurred_at": "2026-14-06T10:50:00Z",
  "data": {
    "notification_id": "ntf-001",
    "recipient_id": "pat-abc123",
    "recipient_type": "patient",
    "channel": "email",
    "template": "diagnosis_ready",
    "sent_at": "2026-14-06T10:50:00Z",
    "status": "delivered"
  }
}
```

10. InfrastructureUpdated — Инфраструктура обновлена
Контекст-источник: IaC & Operations
Семантика: CI/CD-пайплайн применил изменения к инфраструктуре (например, масштабирование ВМ).

Минимальный контракт:
```json
{
  "event_id": "evt-012e4567-e89b-12d3-a456-426614174009",
  "event_type": "InfrastructureUpdated",
  "version": "1.0",
  "occurred_at": "2026-14-06T11:00:00Z",
  "data": {
    "update_id": "upd-iac-001",
    "env": "production",
    "component": "web-vm",
    "action": "scale_up",
    "details": {
      "from_instances": 2,
      "to_instances": 3,
      "reason": "high_load_ai_processing"
    },
    "applied_by": "github-action",
    "plan_hash": "tfplan-abc123",
    "applied_at": "2026-14-06T11:00:00Z"
  }
}
```
