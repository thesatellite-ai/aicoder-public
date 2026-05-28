# Spec

Per-entity reference for the `Spec` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Enums used by this entity

GraphQL enum literals are **bare identifiers in UPPER_SNAKE_CASE**, never quoted strings. `status: ACTIVE` not `status: "active"`. See SKILL.md → "GraphQL gotchas".

| Enum | Valid values |
|---|---|
| `SpecStatus` | `DRAFT`, `ACTIVE`, `DONE`, `ARCHIVED` |

Default status on `createSpec` if omitted: `DRAFT`. Promote to `ACTIVE` once approved, `DONE` when the work it describes shipped. `ARCHIVED` is soft-delete (reversible via `unarchiveSpec`).

## Related mutations

Full set on the server: `createSpec`, `updateSpec`, `deleteSpec`, `archiveSpec`, `unarchiveSpec`. The "Related mutations" section below may be out of date — trust the schema fragment in `apidash/internal/graph/schemas/*.graphql`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Spec implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  title: String!
  summary: String
  problem: String
  goals: [String!]
  constraints: [String!]
  successMetrics: [String!]
  status: SpecStatus!
  version: Int!
  createdByUserID: String
  project: Project!
  plans: [Plan!]
  activities: [Activity!]
}
```

## Create input

```graphql
input CreateSpecInput {
  workspaceID: String
  title: String!
  summary: String
  problem: String
  goals: [String!]
  constraints: [String!]
  successMetrics: [String!]
  status: SpecStatus
  version: Int
  createdByUserID: String
  projectID: ID!
  planIDs: [ID!]
  activityIDs: [ID!]
}
```

## Update input

```graphql
input UpdateSpecInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  summary: String
  clearSummary: Boolean
  problem: String
  clearProblem: Boolean
  goals: [String!]
  appendGoals: [String!]
  clearGoals: Boolean
  constraints: [String!]
  appendConstraints: [String!]
  clearConstraints: Boolean
  successMetrics: [String!]
  appendSuccessMetrics: [String!]
  clearSuccessMetrics: Boolean
  status: SpecStatus
  version: Int
  createdByUserID: String
  clearCreatedByUserID: Boolean
  projectID: ID
  addPlanIDs: [ID!]
  removePlanIDs: [ID!]
  clearPlans: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
}
```

## Where filter (top-level connection)

```graphql
input SpecWhereInput {
  not: SpecWhereInput
  and: [SpecWhereInput!]
  or: [SpecWhereInput!]
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
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  summary field predicates
  """
  summary: String
  summaryNEQ: String
  summaryIn: [String!]
  summaryNotIn: [String!]
  summaryGT: String
  summaryGTE: String
  summaryLT: String
  summaryLTE: String
  summaryContains: String
  summaryHasPrefix: String
  summaryHasSuffix: String
  summaryIsNil: Boolean
  summaryNotNil: Boolean
  summaryEqualFold: String
  summaryContainsFold: String
  """
  problem field predicates
  """
  problem: String
  problemNEQ: String
  problemIn: [String!]
  problemNotIn: [String!]
  problemGT: String
  problemGTE: String
  problemLT: String
  problemLTE: String
  problemContains: String
  problemHasPrefix: String
  problemHasSuffix: String
  problemIsNil: Boolean
  problemNotNil: Boolean
  problemEqualFold: String
  problemContainsFold: String
  """
  status field predicates
  """
  status: SpecStatus
  statusNEQ: SpecStatus
  statusIn: [SpecStatus!]
  statusNotIn: [SpecStatus!]
  """
  version field predicates
  """
  version: Int
  versionNEQ: Int
  versionIn: [Int!]
  versionNotIn: [Int!]
  versionGT: Int
  versionGTE: Int
  versionLT: Int
  versionLTE: Int
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  plans edge predicates
  """
  hasPlans: Boolean
  hasPlansWith: [PlanWhereInput!]
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
}
```

## Related queries (1)

```graphql
  specs(
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
    Ordering options for Specs returned from the connection.
    """
    orderBy: [SpecOrder!]
    """
    Filtering options for Specs returned from the connection.
    """
    where: SpecWhereInput
  ): SpecConnection!
```

## Related mutations (2)

```graphql
  createSpec(input: CreateSpecInput!): Spec!
  updateSpec(id: ID!, input: UpdateSpecInput!): Spec!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.
