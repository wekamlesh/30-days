# Day 2 – Linux Troubleshooting Notes

## First commands during an incident
- uptime
- free -h
- df -h
- systemctl status <service>
- journalctl -xe

## Key lessons
- Logs before restart
- Disk full causes unexpected failures
- Load average ≠ CPU usage


--

YES. This is the right mindset. Day 2 is about **thinking like on-call**, not like a tutorial watcher. Let’s make sure you can *reason* through each one. 🔥

---

## 1️⃣ How do I know why a service failed? (Again — but deeper)

**Mental model:**
👉 *Service failed = Exit code + Logs + Dependencies*

### The muscle-memory flow

```bash
systemctl status <service>
```

Look for:

* `Active: failed`
* `Result:` or `exit-code`
* Timestamp (important!)

Then:

```bash
journalctl -u <service> --since "15 min ago"
```

If still unclear:

* Config check (`nginx -t`, `apachectl configtest`)
* Permissions (files, ports)
* Dependency services (`systemctl list-dependencies <service>`)

🧠 Say this confidently:

> “I start with systemctl status, then journalctl logs, then validate config and dependencies.”

---

## 2️⃣ What’s the **first thing** to check when a server is slow?

🚨 **CPU is NOT always first.**

### Correct order (battle-tested)

#### 1. Load average

```bash
uptime
```

Ask:

* Is load higher than CPU cores?

#### 2. CPU & memory

```bash
top
```

Look for:

* High `%CPU`
* Low `free` memory
* High `wa` (I/O wait)

#### 3. Disk I/O (silent killer)

```bash
iostat
```

or inside `top`:

* `%wa` high = disk bottleneck

📌 Why this matters:

* Many “slow servers” are **disk-blocked**, not CPU-starved

🧠 Say this confidently:

> “I check load first, then CPU, memory, and I/O before blaming the app.”

---

## 3️⃣ How do I tell if it’s **network or app**?

This is a **gold-tier DevOps question** 💎

### Step-by-step isolation

#### 1. Is the port open?

```bash
ss -tulnp
```

❌ Not listening → app issue

---

#### 2. Can I reach it locally?

```bash
curl localhost:8080
```

* ❌ Fails → app issue
* ✅ Works → network issue

---

#### 3. Can I reach it remotely?

```bash
curl <server-ip>:8080
```

* ❌ Fails → firewall / security group
* ✅ Works → DNS / LB / client issue

---

#### 4. DNS check

```bash
dig example.com
```

🧠 Say this confidently:

> “I isolate by testing locally first, then externally, to separate app from network issues.”

---

## 🧠 Core Day 2 Philosophy

> **Logs tell the truth. Google lies.**

* Logs show *what actually happened*
* Metrics show *when*
* Alerts just tell you *something broke*

