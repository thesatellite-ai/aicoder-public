# TermSession

Per-entity reference for the `TermSession` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type TermSession implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  name: String!
  shell: String!
  cwd: String!
  env: Map
  agentKind: TermSessionAgentKind!
  status: TermSessionStatus!
  exitCode: Int
  pid: Int
  hostID: String
  logPath: String
  logBytes: Int!
  logEvents: Int!
  cols: Int!
  rows: Int!
  lastActiveAt: Time!
  endedAt: Time
  project: Project!
}
```

## Create input

```graphql
input CreateTermSessionInput {
  projectId: ID!
  name: String
  shell: String
  cwd: String
  cols: Int
  rows: Int
  env: Map
  agentKind: TermSessionAgentKind
}
```

## Where filter (top-level connection)

```graphql
input TermSessionWhereInput {
  not: TermSessionWhereInput
  and: [TermSessionWhereInput!]
  or: [TermSessionWhereInput!]
  """
  id field predicates
  """
  id: ID
  idNEQ: ID
  idIn: [ID!]
  idNotIn: [ID!]
  idGT: ID
  idGTE: ID
  idLT: ID
  idLTE: ID
  idEqualFold: ID
  idContainsFold: ID
  """
  workspace_id field predicates
  """
  workspaceID: String
  workspaceIDNEQ: String
  workspaceIDIn: [String!]
  workspaceIDNotIn: [String!]
  workspaceIDGT: String
  workspaceIDGTE: String
  workspaceIDLT: String
  workspaceIDLTE: String
  workspaceIDContains: String
  workspaceIDHasPrefix: String
  workspaceIDHasSuffix: String
  workspaceIDIsNil: Boolean
  workspaceIDNotNil: Boolean
  workspaceIDEqualFold: String
  workspaceIDContainsFold: String
  """
  created_at field predicates
  """
  createdAt: Time
  createdAtNEQ: Time
  createdAtIn: [Time!]
  createdAtNotIn: [Time!]
  createdAtGT: Time
  createdAtGTE: Time
  createdAtLT: Time
  createdAtLTE: Time
  createdAtIsNil: Boolean
  createdAtNotNil: Boolean
  """
  updated_at field predicates
  """
  updatedAt: Time
  updatedAtNEQ: Time
  updatedAtIn: [Time!]
  updatedAtNotIn: [Time!]
  updatedAtGT: Time
  updatedAtGTE: Time
  updatedAtLT: Time
  updatedAtLTE: Time
  updatedAtIsNil: Boolean
  updatedAtNotNil: Boolean
  """
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  shell field predicates
  """
  shell: String
  shellNEQ: String
  shellIn: [String!]
  shellNotIn: [String!]
  shellGT: String
  shellGTE: String
  shellLT: String
  shellLTE: String
  shellContains: String
  shellHasPrefix: String
  shellHasSuffix: String
  shellEqualFold: String
  shellContainsFold: String
  """
  cwd field predicates
  """
  cwd: String
  cwdNEQ: String
  cwdIn: [String!]
  cwdNotIn: [String!]
  cwdGT: String
  cwdGTE: String
  cwdLT: String
  cwdLTE: String
  cwdContains: String
  cwdHasPrefix: String
  cwdHasSuffix: String
  cwdEqualFold: String
  cwdContainsFold: String
  """
  agent_kind field predicates
  """
  agentKind: TermSessionAgentKind
  agentKindNEQ: TermSessionAgentKind
  agentKindIn: [TermSessionAgentKind!]
  agentKindNotIn: [TermSessionAgentKind!]
  """
  status field predicates
  """
  status: TermSessionStatus
  statusNEQ: TermSessionStatus
  statusIn: [TermSessionStatus!]
  statusNotIn: [TermSessionStatus!]
  """
  exit_code field predicates
  """
  exitCode: Int
  exitCodeNEQ: Int
  exitCodeIn: [Int!]
  exitCodeNotIn: [Int!]
  exitCodeGT: Int
  exitCodeGTE: Int
  exitCodeLT: Int
  exitCodeLTE: Int
  exitCodeIsNil: Boolean
  exitCodeNotNil: Boolean
  """
  pid field predicates
  """
  pid: Int
  pidNEQ: Int
  pidIn: [Int!]
  pidNotIn: [Int!]
  pidGT: Int
  pidGTE: Int
  pidLT: Int
  pidLTE: Int
  pidIsNil: Boolean
  pidNotNil: Boolean
  """
  host_id field predicates
  """
  hostID: String
  hostIDNEQ: String
  hostIDIn: [String!]
  hostIDNotIn: [String!]
  hostIDGT: String
  hostIDGTE: String
  hostIDLT: String
  hostIDLTE: String
  hostIDContains: String
  hostIDHasPrefix: String
  hostIDHasSuffix: String
  hostIDIsNil: Boolean
  hostIDNotNil: Boolean
  hostIDEqualFold: String
  hostIDContainsFold: String
  """
  log_path field predicates
  """
  logPath: String
  logPathNEQ: String
  logPathIn: [String!]
  logPathNotIn: [String!]
  logPathGT: String
  logPathGTE: String
  logPathLT: String
  logPathLTE: String
  logPathContains: String
  logPathHasPrefix: String
  logPathHasSuffix: String
  logPathIsNil: Boolean
  logPathNotNil: Boolean
  logPathEqualFold: String
  logPathContainsFold: String
  """
  log_bytes field predicates
  """
  logBytes: Int
  logBytesNEQ: Int
  logBytesIn: [Int!]
  logBytesNotIn: [Int!]
  logBytesGT: Int
  logBytesGTE: Int
  logBytesLT: Int
  logBytesLTE: Int
  """
  log_events field predicates
  """
  logEvents: Int
  logEventsNEQ: Int
  logEventsIn: [Int!]
  logEventsNotIn: [Int!]
  logEventsGT: Int
  logEventsGTE: Int
  logEventsLT: Int
  logEventsLTE: Int
  """
  cols field predicates
  """
  cols: Int
  colsNEQ: Int
  colsIn: [Int!]
  colsNotIn: [Int!]
  colsGT: Int
  colsGTE: Int
  colsLT: Int
  colsLTE: Int
  """
  rows field predicates
  """
  rows: Int
  rowsNEQ: Int
  rowsIn: [Int!]
  rowsNotIn: [Int!]
  rowsGT: Int
  rowsGTE: Int
  rowsLT: Int
  rowsLTE: Int
  """
  last_active_at field predicates
  """
  lastActiveAt: Time
  lastActiveAtNEQ: Time
  lastActiveAtIn: [Time!]
  lastActiveAtNotIn: [Time!]
  lastActiveAtGT: Time
  lastActiveAtGTE: Time
  lastActiveAtLT: Time
  lastActiveAtLTE: Time
  """
  ended_at field predicates
  """
  endedAt: Time
  endedAtNEQ: Time
  endedAtIn: [Time!]
  endedAtNotIn: [Time!]
  endedAtGT: Time
  endedAtGTE: Time
  endedAtLT: Time
  endedAtLTE: Time
  endedAtIsNil: Boolean
  endedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
}
```

## Related queries (1)

```graphql
  termSessions(
    """
    Returns the elements in the list that come after the specified cursor.
    """
    after: Cursor
    """
    Returns the first _n_ elements from the list.
    """
    first: Int
    """
    Returns the elements in the list that come before the specified cursor.
    """
    before: Cursor
    """
    Returns the last _n_ elements from the list.
    """
    last: Int
    """
    Ordering options for TermSessions returned from the connection.
    """
    orderBy: [TermSessionOrder!]
    """
    Filtering options for TermSessions returned from the connection.
    """
    where: TermSessionWhereInput
  ): TermSessionConnection!
```

## Related mutations (5)

```graphql
  createTermSession(input: CreateTermSessionInput!): TermSession!
  """Rename a terminal session (label only — does not touch PTY)."""
  forkTermSession(id: ID!): TermSession!
  """Reconcile the DB status of terminal sessions against actual process liveness.
  Scans every row currently marked starting/running/detached and, for rows whose
  PID is dead (or unknown), flips the status to exited or orphaned. Useful after
  killTermSession(id: ID!): TermSession!
  """Fork an exited or running terminal session — spawns a fresh PTY with the
  renameTermSession(id: ID!, name: String!): TermSession!
  """Resize a terminal session (forwards SIGWINCH to the PTY)."""
  resizeTermSession(id: ID!, cols: Int!, rows: Int!): TermSession!
  """Kill a running terminal session. Idempotent — no-op if already exited."""
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
