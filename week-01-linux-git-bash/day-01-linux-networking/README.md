
---

## 1️⃣ What is PID 1?

**PID 1 is the first process started by the Linux kernel.**

* It’s usually `systemd` (or `init` on older systems)
* Every other process is a child of PID 1
* It has **special responsibilities**:

  * Starts services
  * Reaps zombie processes
  * Handles system shutdown/reboot

📌 **Why DevOps cares**

* If PID 1 dies → system panics
* In containers, *your app may be PID 1* → must handle signals properly

🧠 Say this confidently:

> “PID 1 is the parent of all processes and manages service lifecycle and system state.”

---

## 2️⃣ How do I see why a service failed?

### Step-by-step (real-world workflow)

#### 1. Check service status

```bash
systemctl status nginx
```

Look for:

* `failed`
* Exit code
* Error message

#### 2. Check logs

```bash
journalctl -u nginx
```

Or last 10 minutes:

```bash
journalctl -u nginx --since "10 min ago"
```

#### 3. Check config syntax

```bash
nginx -t
```

📌 **Why DevOps cares**

* Production outages = log reading skill test
* Interviews LOVE this question

🧠 Say this confidently:

> “I check service status first, then logs via journalctl, and validate config syntax.”

---

## 3️⃣ How does DNS → HTTPS actually work?

This one separates **real engineers** from tutorial-watchers 👀

### Flow (end-to-end)

1. **User types**: `https://example.com`
2. **DNS resolution**

   * Browser asks DNS resolver
   * Resolver finds IP via Root → TLD → Authoritative DNS
3. **TCP connection**

   * Browser connects to IP on port **443**
4. **TLS handshake**

   * Server sends SSL certificate
   * Browser verifies CA + domain
   * Encryption keys exchanged
5. **HTTPS request**

   * Encrypted HTTP request sent
   * Server responds with encrypted data

📌 **Where things break**

* DNS wrong → site not found
* Cert expired → HTTPS error
* Port blocked → timeout

🧠 Say this confidently:

> “DNS resolves the domain to an IP, then TLS secures the connection before HTTP traffic flows.”

---

## 4️⃣ What’s running on this server right now?

### Core commands you MUST know

#### Processes

```bash
ps aux
```

#### Real-time view

```bash
top
```

or better:

```bash
htop
```

#### Services

```bash
systemctl list-units --type=service --state=running
```

#### Ports in use

```bash
ss -tulnp
```

📌 **Why DevOps cares**

* You must identify:

  * What’s consuming CPU?
  * What’s listening on ports?
  * What shouldn’t be running?

🧠 Say this confidently:

> “I check running processes, active services, and listening ports to understand system state.”

---
