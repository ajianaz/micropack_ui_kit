# MPCard Architecture Diagrams

## Component Structure Overview

```mermaid
graph TB
    subgraph "MPCard Component"
        A[MPCard] --> B[Content Slots]
        A --> C[Variant System]
        A --> D[Responsive System]
        A --> E[Theme Integration]
        A --> F[Interactive States]
        A --> G[Accessibility]

        B --> B1[Header Slot]
        B --> B2[Body Slot]
        B --> B3[Footer Slot]
        B --> B4[Child Slot]

        C --> C1[Primary]
        C --> C2[Secondary]
        C --> C3[Elevated]
        C --> C4[Outlined]
        C --> C5[Filled]
        C --> C6[Interactive]
        C --> C7[Display]
        C --> C8[Glass]

        D --> D1[Layout Types]
        D --> D2[Breakpoints]
        D --> D3[Adaptation Logic]

        D1 --> D1A[Vertical]
        D1 --> D1B[Horizontal]
        D1 --> D1C[Grid]
        D1 --> D1D[Adaptive]

        E --> E1[Theme-Aware Colors]
        E --> E2[Dark Mode Support]
        E --> E3[Custom Themes]

        F --> F1[Hover State]
        F --> F2[Pressed State]
        F --> F3[Disabled State]
        F --> F4[Selected State]
        F --> F5[Focus State]

        G --> G1[Semantic Labels]
        G --> G2[Focus Management]
        G --> G3[Keyboard Navigation]
    end
```

## Content Slot Architecture

```mermaid
graph LR
    subgraph "Content Organization Patterns"
        A[Slot-Based] --> A1[Header]
        A --> A2[Body]
        A --> A3[Footer]

        B[Single Child] --> B1[Custom Content]

        C[Predefined Patterns] --> C1[Media Card]
        C --> C2[Content Card]
        C --> C3[Interactive Card]

        D[Builder Pattern] --> D1[Fluent API]
        D --> D2[Method Chaining]
    end
```

## Responsive Layout System

```mermaid
graph TD
    A[Screen Size Detection] --> B{Width Check}

    B -->|<= 600px| C[Mobile Layout]
    B -->|601px - 1024px| D[Tablet Layout]
    B -->|> 1024px| E[Desktop Layout]

    C --> F[Vertical Stack]
    D --> G{Layout Config}
    E --> H{Layout Config}

    G -->|Custom| I[Custom Tablet Layout]
    G -->|Default| J[Horizontal Layout]

    H -->|Custom| K[Custom Desktop Layout]
    H -->|Default| L[Horizontal Layout]

    F --> M[Render Card]
    I --> M
    J --> M
    K --> M
    L --> M
```

## Theme Integration Flow

```mermaid
graph TD
    A[Color Request] --> B{Custom Color?}

    B -->|Yes| C[Use Custom Color]
    B -->|No| D{Theme Data?}

    D -->|Yes| E[Use Theme Color]
    D -->|No| F{Variant Type}

    F -->|Primary| G[context.mp.primary]
    F -->|Secondary| H[context.mp.neutral20]
    F -->|Surface| I[context.mp.adaptiveBackgroundColor]
    F -->|Elevated| I
    F -->|Outlined| I
    F -->|Filled| J[context.mp.neutral20]
    F -->|Interactive| K[context.mp.primarySurface]
    F -->|Display| I
    F -->|Glass| L[context.mp.neutral100.withAlpha]

    C --> M[Apply Color]
    E --> M
    G --> M
    H --> M
    I --> M
    J --> M
    K --> M
    L --> M
```

## Interactive State Management

```mermaid
stateDiagram-v2
    [*] --> Normal

    Normal --> Hover: Mouse Enter
    Hover --> Normal: Mouse Exit

    Normal --> Pressed: Touch Down
    Pressed --> Normal: Touch Up/Cancel

    Normal --> Focused: Focus Gain
    Focused --> Normal: Focus Lost

    Normal --> Disabled: enabled = false
    Disabled --> Normal: enabled = true

    Normal --> Selected: selected = true
    Selected --> Normal: selected = false

    Hover --> Pressed: Touch Down
    Focused --> Pressed: Touch Down
    Selected --> Pressed: Touch Down
```

## Component API Design

```mermaid
graph TB
    subgraph "API Layers"
        A[Core Constructor] --> B[All Parameters]

        C[Named Constructors] --> C1[MPCard.media]
        C --> C2[MPCard.content]
        C --> C3[MPCard.interactive]

        D[Builder Pattern] --> D1[MPCard.builder]
        D --> D2[Fluent Methods]
        D --> D3[build()]

        E[Inheritance] --> E1[StatefulWidget]
        E --> E2[Theme Integration]
        E --> E3[Accessibility]
    end

    B --> F[Flexible Usage]
    C1 --> F
    C2 --> F
    C3 --> F
    D3 --> F
```

## Performance Optimization

```mermaid
graph LR
    subgraph "Optimization Strategies"
        A[ValueNotifier] --> A1[Hover State]
        A --> A2[Pressed State]

        B[ValueListenableBuilder] --> B1[Selective Rebuilds]
        B --> B2[Minimal Widget Tree]

        C[Lazy Loading] --> C1[Content on Demand]
        C --> C2[Conditional Rendering]

        D[Efficient Comparisons] --> D1[const Constructors]
        D --> D2[Operator ==]
    end
```

## Testing Architecture

```mermaid
graph TD
    subgraph "Test Pyramid"
        A[Unit Tests] --> A1[Color Resolution]
        A --> A2[State Management]
        A --> A3[Theme Integration]

        B[Widget Tests] --> B1[Interaction Handling]
        B --> B2[Layout Adaptation]
        B --> B3[Accessibility]

        C[Integration Tests] --> C1[Theme Switching]
        C --> C2[Responsive Behavior]
        C --> C3[Performance]

        D[Golden Tests] --> D1[Visual Consistency]
        D --> D2[Theme Variations]
    end
```

## File Organization

```mermaid
graph TD
    A[lib/src/components/card/] --> B[mp_card.dart]
    A --> C[enums/]
    A --> D[theme/]
    A --> E[responsive/]
    A --> F[builders/]

    C --> C1[mp_card_variant.dart]
    C --> C2[mp_card_size.dart]
    C --> C3[mp_card_layout.dart]

    D --> D1[mp_card_theme.dart]
    D --> D2[mp_card_theme_data.dart]

    E --> E1[mp_card_responsive.dart]
    E --> E2[mp_card_breakpoints.dart]

    F --> F1[mp_card_builder.dart]
    F --> F2[mp_card_media.dart]
```

## Migration Path

```mermaid
graph LR
    subgraph "Migration Sources"
        A[MPArticleCard] --> A1[Content Pattern]
        A --> A2[Media Support]

        B[Container] --> B1[Basic Structure]
        B --> B2[Styling]

        C[Card] --> C1[Material Design]
        C --> C2[Elevation]
    end

    subgraph "Migration Target"
        D[MPCard] --> D1[Unified API]
        D --> D2[Enhanced Features]
        D --> D3[Backward Compatibility]
    end

    A1 --> D
    B1 --> D
    C1 --> D
    A2 --> D1
    B2 --> D1
    C2 --> D1
```

## Theme Color Mapping

```mermaid
graph TD
    A[MPCard Variant] --> B{Color Type}

    B -->|Background| C[Background Colors]
    B -->|Border| D[Border Colors]
    B -->|State| E[State Colors]

    C --> C1[Primary Alpha]
    C --> C2[Neutral Colors]
    C --> C3[Adaptive Colors]

    D --> D1[Primary Border]
    D --> D2[Adaptive Border]
    D --> D3[Transparent]

    E --> E1[Hover Colors]
    E --> E2[Pressed Colors]
    E --> E3[Focus Colors]
    E --> E4[Disabled Colors]
```

## Responsive Breakpoint System

```mermaid
graph LR
    subgraph "Screen Sizes"
        A[Mobile] --> A1[≤ 600px]
        B[Tablet] --> B1[601px - 1024px]
        C[Desktop] --> C1[> 1024px]
    end

    subgraph "Layout Adaptation"
        A1 --> D[Vertical Layout]
        B1 --> E[Horizontal/Custom]
        C1 --> F[Horizontal/Custom]
    end

    subgraph "Content Adjustments"
        D --> G[Compact Spacing]
        E --> H[Medium Spacing]
        F --> I[Full Spacing]
    end